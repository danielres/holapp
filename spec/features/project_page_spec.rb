require 'spec_helper'
require 'fast_authentication_spec_helper'

def confirmed_user
  User.create!(email: "visitor@user.com", password: 'password', name: "Visitor#{rand}").tap do |u|
    u.confirm!
  end
end

describe 'Project page' do
  let(:project){ Project.create!(name: "Project #{rand}") }
  context 'when authenticated' do
    let(:user){ confirmed_user }
    before(:each) do
      login_as(user, scope: :user)
    end
    it  'works' do
      visit project_path(project)
    end
  end

end
