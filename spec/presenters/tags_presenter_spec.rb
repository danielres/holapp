require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe TagsPresenter do

  describe 'rendering to html' do
    let(:user){ double 'user' }
    subject{ described_class.new(user, tags, view_context) }
    let(:tag1){ build(:tag, name: 'tag1') }
    let(:tag2){ build(:tag, name: 'tag2') }
    let(:tags){ [ tag1, tag2 ] }
    let(:view_context){ view }
    it 'presents the tags' do
      expect( fragment(subject.to_html) ).to have_the 'tags-list'
      expect( fragment(subject.to_html) ).to have_content('tag1')
      expect( fragment(subject.to_html) ).to have_content('tag2')
    end
  end

end
