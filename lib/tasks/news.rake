namespace :news do
  desc "Sends a customized to each user"
  task send_digests: :environment do
    [ User.find(1) ].each do |user|
      News::Mailer.digest_email(user).deliver
    end
  end

end
