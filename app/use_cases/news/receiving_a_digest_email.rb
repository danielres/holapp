module News
  class ReceivingADigestEmail

    include IsAnAdvancedCallable

    def initialize(recipient_user)
      @recipient  = recipient_user
      @news_items = News::Fetcher.new(@recipient, 'interesting').call
    end

    private

      def execution
        News::Mailer
          .digest_email(
            @recipient,
            @news_items,
          )
          .deliver
      end

      def authorized?
        Ability.new(@recipient).can? :read, News::Item
      end

      def journal_event
        {
          user:    @recipient,
          action:  :received_news_digest_by_mail,
          object:  nil,
          details: { news_items: @news_items},
        }
      end

  end
end
