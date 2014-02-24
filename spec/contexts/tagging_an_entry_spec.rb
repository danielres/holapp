require 'spec_helper'

def build_admin_user
  User.new.tap{ |u| u.add_role(:admin) }
end

describe TaggingAnEntry do

  describe 'tagging a project on skills' do
    let(:tagging){ described_class.new(tagger, taggable, tag_list, tag_field)  }
    let(:taggable){ Project.create(name: 'myproj') }
    let(:tag_list){ 'tag1, tag2' }
    let(:tag_field){ :skills }
    before(:each) do
      tagging.tag
    end
    context 'as a guest user' do
      let(:tagger){ User.new }
      it 'does not tag' do
        expect( taggable.tags_on(:skills).count ).to eq 0
        expect( taggable.tag_list_on :skills ).not_to include 'tag1'
        expect( taggable.tag_list_on :skills ).not_to include 'tag2'
      end
    end
    context 'as an authorized tagger' do
      let(:tagger){ build_admin_user }
      it 'tags the project on skills' do
        expect( taggable.tags_on(:skills).count ).to eq 2
        expect( taggable.tag_list_on :skills ).to include 'tag1'
        expect( taggable.tag_list_on :skills ).to include 'tag2'
      end
    end
  end

end
