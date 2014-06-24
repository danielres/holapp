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
    let(:taggable){ build(:person, first_name: 'person_name') }
    let(:execution){ ->{ subject.execute } }
    let(:taggings){ [ tagging1, tagging2 ] }
    let(:tagging1){ Tagging.new(tag: build(:tag, name: 'tag1'), quantifier: 3, taggable: taggable, context: 'skills' ) }
    let(:tagging2){ Tagging.new(tag: build(:tag, name: 'tag2'), quantifier: 1, taggable: taggable, context: 'skills' )}
    before do
      subject.taggings = taggings
    end
    it 'presents only the top taggings' do
      expect( fragment(subject.to_html) ).to     have_the     'top-skills'
      expect( fragment(subject.to_html) ).to     have_content 'tag1'
      expect( fragment(subject.to_html) ).to     have_content 'person_name'
      expect( fragment(subject.to_html) ).not_to have_content 'tag2'
    end
  end

end
