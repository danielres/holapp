require 'spec_helper'

describe TaggingAnEntry do

  describe 'tagging a project on skills' do
    let(:tagging){ described_class.new(tagger, taggable, tags, tag_field)  }
    let(:taggable){ Project.new }
    let(:tags){ [ 'tag1', 'tag2' ] }
    let(:tag_field){ :skills }
    before(:each) do
      tagging.tag
    end
    context 'as a guest user' do
      let(:tagger){ User.new }
      it 'does not tag' do
        expect( taggable.tags.inspect ).not_to include 'tag1'
        expect( taggable.tags.inspect ).not_to include 'tag2'
      end
    end
    context 'as an authorized tagger' do
    let(:any_authorized_role){ :admin }
    let(:tagger){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
    it 'tags the project on skills' do
      expect( taggable.tags[:skills] ).to include 'tag1'
      expect( taggable.tags[:skills] ).to include 'tag2'
    end
    end
  end

end
