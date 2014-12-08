module News
  class ReceivingADigestEmail

    include IsAnAdvancedCallable

    attr_reader :config
    attr_reader :email
    attr_writer :news_items

    def initialize(recipient_user, dry_run: false)
      @recipient  = recipient_user
      @config     = News::UserConfig.where(user: @recipient).first_or_create
      @news_items = News::Fetcher.new(@recipient, 'interesting', @config.digest_sent_at).call
      @email      = News::Mailer.digest_email( @recipient, @news_items)
      @dry_run    = dry_run
    end

    private

      def execution
        return if @dry_run
        puts ""
        puts "Sending digest with #{ @news_items.count } news to #{ @recipient.name.ljust(20, ' ') } #{ @news_items.map(&:id) }"
        if @config.receive_digest == false
          puts 'Canceled: user refuses digests'
          return :user_refuses_digests
        end
        if @news_items.empty?
          puts 'Canceled: news list is empty'
          return :news_items_empty
        end
        @email.deliver && @config.refresh_digest_sent_at!
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
