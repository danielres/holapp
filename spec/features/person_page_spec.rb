require 'spec_helper'
require 'fast_authentication_spec_helper'

def confirmed_user
  User.create!(email: "visitor@user.com", password: 'password', name: "Visitor#{rand}").tap do |u|
    u.confirm!
  end
end

describe 'Person page' do
  let(:person){ User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'User name') }
  context 'when authenticated' do
    let(:user){ confirmed_user }
    before(:each) do
      login_as(user, scope: :user)
    end
    it  'works' do
      visit person_path(person)
    end
  end

end
