module News
  class ReceivingADigestEmail

    include IsAnAdvancedCallable

    attr_reader :config
    attr_reader :email
    attr_accessor :news_items

    def initialize(recipient_user, dry_run: false)
      @recipient  = recipient_user
      @config     = News::UserConfig.where(user: @recipient).first_or_create
      @news_items = News::Fetcher.new(@recipient, 'interesting', @config.digest_sent_at).call
      @email      = News::Mailer.digest_email( @recipient, @news_items)
      @dry_run    = dry_run
    end

    private

      def execution
        msg = ""
        msg << "Sending digest with #{ @news_items.count } news to #{ @recipient.name.ljust(20, ' ') } \n"
        msg << @news_items.map{|n| n.id.to_s + ": " + n.summary.truncate(80) }.join("\n")  if @news_items.any?
        if @config.receive_digest == false
          msg << 'Canceled: user refuses digests'
          puts msg
          return msg
        end
        if @news_items.empty?
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
        return {} if @news_items.empty?
        {
          user:    @recipient,
          action:  :received_news_digest_by_mail,
          object:  nil,
          details: { news_items: @news_items},
        }
      end

  end
end
