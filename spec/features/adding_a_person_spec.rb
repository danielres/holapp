require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'

describe 'Adding a person' do
  let(:super_user){ create(:super_user) }

  context 'as superuser' do

    describe 'using the form to add a person' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit '/'
        within 'form.new_user' do
          page.fill_in :user_name, with: 'Alfred'
          page.find('input[type=submit]').click
        end
      end
      it %q[adds the person to the list of persons] do
        within the('people-list') do
          expect( page ).to have_content 'Alfred'
        end
      end
    end

  end

end


