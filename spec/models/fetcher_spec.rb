require 'spec_helper'

describe News::Fetcher, :news do

  let(:tagged_user){ FactoryGirl.create(:user      ) }
  let(:super_user ){ FactoryGirl.create(:super_user) }

  let!(:news_item_not_interesting){ FactoryGirl.create(:news_item, summary: 'Not interesting' ) }
  let!(:news_item_interesting    ){ FactoryGirl.create(:news_item, summary: 'Very interesting') }

  before do
    AddingTaggings.new(super_user, tagged_user          , 'tag1, tag2', :motivations).call
    AddingTaggings.new(super_user, news_item_interesting, 'tag1, tag2', :themes     ).call
  end

  describe "using with filter 'all'" do
    it 'includes all news items' do
      expect( News::Fetcher.new(tagged_user, 'all').call ).to include news_item_interesting
      expect( News::Fetcher.new(tagged_user, 'all').call ).to include news_item_not_interesting
    end

  end

  describe "using with filter 'interesting'" do
    it 'includes only interesting news items' do
      expect( News::Fetcher.new(tagged_user, 'interesting').call ).to include news_item_interesting
      expect( News::Fetcher.new(tagged_user, 'interesting').call ).not_to include news_item_not_interesting
    end

  end

end
