require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'

describe 'Config page', :slow, :js do

  context 'for a superuser' do
    let(:user){ create(:super_user) }
    before(:each) do
      login_as(user, scope: :user)
    end

    before(:each) do
      visit user_configs_path
    end

    it 'supports choosing to receive the news digest by email' do
      user_config = News::UserConfig.first
      expect( user_config.receive_digest ).to be_nil
      within the 'news_user_config-editor' do
        edit_in_place_boolean user_config, :receive_digest
      end
      user_config.reload
      expect( user_config.receive_digest ).to be_true
    end

  end

end
