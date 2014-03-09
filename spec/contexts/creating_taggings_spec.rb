require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe CreatingTaggings do
  subject{ described_class.new(user, taggable, tag_list, tag_field)  }
  let(:taggable){ create(:person) }
  let(:tag_list){ 'tag1, tag2' }
  let(:tag_field){ :skills }


  context 'by a guest user' do
    let(:user){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.tag }.to raise_error ActionForbiddenError
    end
  end


  context 'by a superuser' do
    let(:user){ create(:super_user) }
    it "is supported given a comma-separated list of tags" do
      subject.tag
      expect( taggable.tags_on(:skills).count ).to eq 2
      expect( taggable.tag_list_on :skills ).to include 'tag1'
      expect( taggable.tag_list_on :skills ).to include 'tag2'
    end
    describe 'performing' do
      let(:perform){ ->{ subject.tag } }
      include_examples 'a controller commander'
    end

  end

  include_examples 'a form provider'

end
