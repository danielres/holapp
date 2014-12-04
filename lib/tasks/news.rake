namespace :news do
  desc "Sends a customized to each user"
  task send_digests: :environment do
    User.all.each do |user|
      News::ReceivingADigestEmail.new(user).call
    end
  end

end
