module News
  class ReceivingADigestEmail

    include IsAnAdvancedCallable

    attr_reader :config
    attr_reader :email
    attr_accessor :news_items

    def initialize(recipient_user, dry_run: false)
      @recipient  = recipient_user
      @config     = News::UserConfig.where(user: @recipient).first_or_create
      @all_news_items           = News::Fetcher.new(@recipient, 'all'        , @config.digest_sent_at).call
      @interesting_news_items   = News::Fetcher.new(@recipient, 'interesting', @config.digest_sent_at).call
      @uninteresting_news_items = @all_news_items - @interesting_news_items
      @email      = News::Mailer.digest_email(@recipient, @interesting_news_items, @uninteresting_news_items)
      @dry_run    = dry_run
    end

    def call *args
      begin
        super
      rescue ActionForbiddenError => e
        msg = "\n--------------------------------------------------------------------------------"
        msg << "\n"
        msg << "CANCELED #{self.class} for user '#{@recipient}': #{e.message}"
        puts   msg
        return msg
      end
    end

    private

      def execution
        msg = "\n--------------------------------------------------------------------------------"
        msg << "\n"
        msg << "Sending digest with #{ @interesting_news_items.count } (interesting) + #{ @uninteresting_news_items.count } (other) news to #{ @recipient.name.ljust(20, ' ') } \n"
        msg << "\n"
        msg << "Interesting:"
        msg << "\n"
        msg << @interesting_news_items.map{|n| n.id.to_s + ": " + n.summary.truncate(80) }.join("\n")  if @interesting_news_items.any?
        msg << "\n"
        msg << "Other:"
        msg << "\n"
        msg << @uninteresting_news_items.map{|n| n.id.to_s + ": " + n.summary.truncate(80) }.join("\n")  if @uninteresting_news_items.any?
        msg << "\n"
        if @config.receive_digest == false
          msg << 'Canceled: user refuses digests'
          puts msg
          return msg
        end
        if @all_news_items.empty?
          msg << 'Canceled: no fresh news'
          puts msg
          return msg
        end
        puts msg
        return msg if @dry_run
        @email.deliver && @config.refresh_digest_sent_at!
        return msg
      end

      def authorized?
        Ability.new(@recipient).can? :read, News::Item
      end

      def journal_event
        return {} if @dry_run
        return {} if @config.receive_digest == false
        return {} if @all_news_items.empty?
        {}
      end

  end
end
