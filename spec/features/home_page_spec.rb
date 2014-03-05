require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'factories_spec_helper'


describe 'Homepage' do

  context 'when authenticated' do
    let(:user){ create(:no_roles_user) }

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
