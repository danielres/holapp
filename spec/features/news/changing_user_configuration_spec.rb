require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'factories_spec_helper'
require 'purpose_selector_spec_helper'

describe 'Config page', :slow do

  context 'for a superuser' do
    let(:user){ create(:super_user) }
    before(:each) do
      login_as(user, scope: :user)
    end

    before(:each) do
      visit user_configs_path
    end

    it 'supports choosing to receive the news digest by email' do
      expect( page ).to have_content 'UserConfigs#index'
    end

  end

end
