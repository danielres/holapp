require_relative 'spec_helper'

describe 'Deleting a news item', :slow, :news, :js do
  let(:super_user){ create(:super_user) }
  let!(:news_item){ create(:news_item, summary: 'The summary', body: 'The body') }

  context 'as superuser' do

    describe 'deleting the news item' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit news_path
        within the('news_items-list') do
          find( the 'delete-action').click
          wait_until_angular_ready
        end
      end
      it 'destroys the news item' do
        expect( News::Item.count ).to eq 0
      end
    end

  end

end
