require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'factories_spec_helper'

describe 'Person page' do
  let(:person){ create(:person) }
  context 'when authenticated' do
    let(:user){ create(:no_roles_user) }
    before(:each) do
      login_as(user, scope: :user)
    end
    it 'works' do
      visit person_path(person)
    end
  end

end
