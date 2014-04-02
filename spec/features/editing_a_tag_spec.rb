require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'
require_relative 'shared_examples_for_taggables_spec'

describe 'Editing a tag', :slow do
  let!(:tag){ create(:tag) }

  context 'as a superuser' do
    let(:super_user){ create(:super_user) }

    before(:each) do
      login_as(super_user, scope: :user)
    end

    describe 'updating the tag description', js: true do
      before(:each) do
        tag.update(description: 'description')
        visit tag_path(tag)
      end
      it 'updates the description on the tag page' do
        edit_in_place_textarea(tag, :description, 'updated description')
        visit tag_path(tag)
        expect( page ).to have_content('updated description')
      end
    end

  end

end


