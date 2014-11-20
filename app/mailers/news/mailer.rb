class News::Mailer < ActionMailer::Base
  default from: "from@example.com"

  def digest_email(user)
    subject     = "Your Marketplace news digest"
    news_items  = News::Fetcher.new(user, 'interesting').call
    mail(to: user.email, subject: subject) do |format|
      format.html { render locals: { news_items: news_items, user: user} }
    end
  end

end
