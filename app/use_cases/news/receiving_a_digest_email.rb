module News
  class ReceivingADigestEmail

    include IsAnAdvancedCallable

    attr_reader :config
    attr_writer :news_items

    def initialize(recipient_user)
      @recipient  = recipient_user
      @config     = News::UserConfig.first_or_create(user: @recipient)
      @news_items = News::Fetcher.new(@recipient, 'interesting', @config.digest_sent_at).call
    end

    private

      def execution
        return :user_refuses_digests if @config.receive_digest? == false
        return :news_items_empty     if @news_items.empty?
        News::Mailer
          .digest_email(
            @recipient,
            @news_items,
          )
          .deliver && @config.refresh_digest_sent_at!
      end

      def authorized?
        Ability.new(@recipient).can? :read, News::Item
      end

      def journal_event
        return {} if @config.receive_digest? == false
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
