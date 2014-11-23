require "spec_helper"

describe News::Mailer do
  let(:user){ FactoryGirl.create :no_roles_user }
  describe 'sending a digest email' do
    it 'sends an email to a user containing news' do
      email_text = described_class.digest_email(user).body.to_s.html_safe
      expect( email_text ).to have_css('table')
    end
  end

end
