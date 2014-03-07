require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_list_providers'
# require_relative 'shared_examples_for_controller_commanders'

describe TaggingAnEntry do
  subject{ described_class.new(user, taggable, tag_list, tag_field)  }

  describe 'tagging a project on skills' do
    let(:taggable){ create(:project) }
    let(:tag_list){ 'tag1, tag2' }
    let(:tag_field){ :skills }
    context 'by a guest user' do
      let(:user){ build(:no_roles_user) }
      it 'does not tag' do
        subject.tag
        expect( taggable.tags_on(:skills) ).to be_empty
        expect( taggable.tag_list_on :skills ).not_to include 'tag1'
        expect( taggable.tag_list_on :skills ).not_to include 'tag2'
      end
    end
    context 'by an authorized user' do
      let(:user){ create(:super_user) }
      it 'tags the project on skills' do
        subject.tag
        expect( taggable.tags_on(:skills).count ).to eq 2
        expect( taggable.tag_list_on :skills ).to include 'tag1'
        expect( taggable.tag_list_on :skills ).to include 'tag2'
      end
    end

    include_examples 'a form provider'
    include_examples 'a list provider'

  end


end
