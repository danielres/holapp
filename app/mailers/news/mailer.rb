class News::Mailer < ActionMailer::Base
  default from: ENV['MAILER_FROM_ADDRESS'] || "from@example.com"

  def digest_email(user, news_items_interesting, news_items_other)
    subject     = "Your Marketplace news digest"
    mail(to: user.email, subject: subject) do |format|
      format.html do
        render locals: { news_items_interesting: news_items_interesting, news_items_other: news_items_other, user: user}
      end
    end
  end

end
