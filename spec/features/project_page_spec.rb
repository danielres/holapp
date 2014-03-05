require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'factories_spec_helper'

describe 'Project page' do
  let(:project){ create(:project) }
  context 'when authenticated' do
    let(:user){ create(:no_roles_user) }
    before(:each) do
      login_as(user, scope: :user)
    end
    it 'works' do
      visit project_path(project)
    end
  end

end
