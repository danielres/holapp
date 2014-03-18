require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe TaggingsPresenter do

  describe 'rendering to html' do
    subject{ described_class.new(taggings, tag_field, view_context) }
    let(:taggings){ [ tagging1, tagging2] }
    let(:tagging1){ Tagging.new(tag_id: tag1.id, context: tag_field) }
    let(:tagging2){ Tagging.new(tag_id: tag2.id, context: tag_field) }
    let(:tag1){ create(:tag, name: 'skill1') }
    let(:tag2){ create(:tag, name: 'skill2') }
    let(:tag_field){ :skills }
    let(:view_context){ view }
    it 'presents the taggings' do
      expect( fragment(subject.to_html) ).to have_the 'skills-list'
      expect( fragment(subject.to_html) ).to have_content('skill1')
      expect( fragment(subject.to_html) ).to have_content('skill2')
    end
  end

end
