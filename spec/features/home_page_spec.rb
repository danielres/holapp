require 'spec_helper'
require 'fast_authentication_spec_helper'

def create_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end
def confirmed_user
  create_random_person.tap do |u|
    u.save!
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
