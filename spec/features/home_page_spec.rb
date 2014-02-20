require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

def confirmed_user
  User.create!(email: "visitor@user.com", password: 'password', name: 'Visitor').tap do |u|
    u.confirm!
  end
end

describe 'Homepage' do
  context 'when authenticated' do
    let(:user){ confirmed_user }
    before(:each) do
      login_as(user, scope: :user)
      visit '/'
    end
    it 'displays a people section' do
      expect( page ).to have_content 'People'
    end
    it 'displays a projects section' do
      expect( page ).to have_content 'Projects'
    end
    it 'displays a top skills section' do
      expect( page ).to have_content 'Top skills'
    end
    it 'displays a top motivations section' do
      expect( page ).to have_content 'Top motivations'
    end
  end

end
