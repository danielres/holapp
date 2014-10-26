require_relative 'spec_helper'

describe 'Live-editing a news item using markdown', :slow, :news, :js do
  let(:super_user){ create(:super_user) }
  let!(:news_item){ create(:news_item, summary: 'Initial summary', body: 'Initial body') }

  context 'as superuser' do

    describe 'using the form to edit the news item using markdown' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit news_path
        within the('news_items-list') do
          find( the 'update-action').click
        end
        within the 'news_item-form' do
          fill_in :news_item_summary, with: 'Updated **strong summary**'
          fill_in :news_item_body   , with: 'Updated **strong body**'
          wait_until_angular_ready
        end
      end
      it 'displays news item properly rendered' do
        expect( page.html ).to include '<p>Updated <strong>strong body</strong></p>'
        expect( page.html ).to include '<p>Updated <strong>strong summary</strong></p>'
      end
    end

  end

end
