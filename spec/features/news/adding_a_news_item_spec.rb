require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'

describe 'Adding a news item', :slow, :news, driver: :selenium do
  let(:super_user){ create(:super_user) }

  context 'as superuser' do

    describe 'using the form to add a news item' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit '/news'
        within the('news_item-form') do
          page.fill_in :news_item_summary, with: 'The summary'
          page.fill_in :news_item_body,    with: 'The body'
          page.find('input[type=submit]').click
        end
      end
      it %q[adds the news item to the list of news items] do
        visit '/news'
        within the('news_items-list') do
          expect( page ).to have_content 'The summary'
          expect( page ).to have_content 'The body'
        end
      end
    end

  end

end


