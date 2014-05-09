require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe TopsByTagFieldPresenter do

  subject{ described_class.new(tag_field: tag_field, min_level: min_level, view_context: view_context) }
  let(:tag_field){ 'skills' }
  let(:min_level){ 3 }
  let(:view_context){ view }

  context 'when taggings have been applied' do
    let(:user){ build(:no_roles_user) }
    let(:taggable){ create(:person, first_name: 'person_name') }
    let(:execution){ ->{ subject.execute } }
    let(:authorization){ ->{ allow(user).to receive( :can_add_tags? ){ true } } }

    before(:each) do
      authorization.call
    end
    before(:each) do
      AddingTaggings.new(user, taggable, 'tag1', tag_field).execute
      Tagging.last.update_attributes(quantifier: 3)
    end
    before(:each) do
      AddingTaggings.new(user, taggable, 'tag2', tag_field).execute
      Tagging.last.update_attributes(quantifier: 2)
    end
    it 'presents only the top taggings' do
      expect( fragment(subject.to_html) ).to     have_the     'top-skills'
      expect( fragment(subject.to_html) ).to     have_content 'tag1'
      expect( fragment(subject.to_html) ).to     have_content 'person_name'
      expect( fragment(subject.to_html) ).not_to have_content 'tag2'
    end
  end

end
