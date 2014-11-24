require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'
require_relative '../shared_examples_for_taggables_spec'

describe 'Editing a news item', :slow do
  let!(:news_item){ create(:news_item) }

  context 'as a superuser' do
    let(:super_user){ create(:super_user) }

    before(:each) do
      login_as(super_user, scope: :user)
    end


    describe 'updating the news_item details', js: true do
      before(:each) do
        news_item.update(
              summary: 'initial_summary',
                body:  'initial_body',
            language:  'fr',
        )
        visit news_item_path(news_item)
      end
      it "supports updating 'summary' and 'body' on the news_item's page" do
        edit_in_place_textarea_with_activator(news_item, :summary, 'updated_summary', 'summary_edit_action')
        edit_in_place_textarea_with_activator(news_item, :body   , 'updated_body'   , 'body_edit_action'       )

        visit news_item_path(news_item)

        expect( page ).to have_content('updated_summary')
        expect( page ).to have_content('updated_body')
      end

      it "supports updating the language on the news_item's page"

    end

    describe 'tagging' do
      let(:taggable){ news_item }
      let(:tag_field){ :themes }
      include_examples 'a taggable'
    end

  end

end


