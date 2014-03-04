require 'spec_helper'
require 'factories_spec_helper'

describe TaggingAnEntry do

  describe 'tagging a project on skills' do
    subject{ described_class.new(tagger, taggable, tag_list, tag_field)  }
    let(:taggable){ create(:project) }
    let(:tag_list){ 'tag1, tag2' }
    let(:tag_field){ :skills }
    before(:each) do
      subject.tag
    end
    context 'by a guest user' do
      let(:tagger){ build(:no_roles_user) }
      it 'does not tag' do
        expect( taggable.tags_on(:skills) ).to be_empty
        expect( taggable.tag_list_on :skills ).not_to include 'tag1'
        expect( taggable.tag_list_on :skills ).not_to include 'tag2'
      end
    end
    context 'by an authorized tagger' do
      let(:tagger){ create(:super_user) }
      it 'tags the project on skills' do
        expect( taggable.tags_on(:skills).count ).to eq 2
        expect( taggable.tag_list_on :skills ).to include 'tag1'
        expect( taggable.tag_list_on :skills ).to include 'tag2'
      end
    end
  end

end
