require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'

describe 'Editing a news item', :slow, :news, driver: :selenium do
  let(:super_user){ create(:super_user) }
  let!(:news_item){ create(:news_item, summary: 'Initial summary', body: 'Initial body') }

  context 'as superuser' do

    describe 'using the form to edit the news item' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit news_path
        within the('news_items-list') do
          find( the 'update-action').click
        end
        within the 'news_item-form' do
          fill_in :news_item_summary, with: 'Updated summary'
          fill_in :news_item_body   , with: 'Updated body'
          find('input[type=submit]').click
          sleep 0.1
        end
      end
      it %q[updates the news item] do
        item = News::Item.last
        expect( item.summary ).to eq 'Updated summary'
        expect( item.body    ).to eq 'Updated body'
      end
    end

  end

end
