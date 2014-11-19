class News::Mailer < ActionMailer::Base
  default from: "from@example.com"

  def digest_email(user)
    subject     = "Your Marketplace news digest"
    news_items  = News::Fetcher.new(user, 'interesting').call
    digest_body = News::Digest.new(news_items).call
    mail(to: user.email, subject: subject) do |format|
      format.html { render locals: { digest_body: digest_body, user: user} }
    end
  end

end
