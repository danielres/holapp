require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingTaggings do
  subject{ described_class.new(user, taggable, tag_list, tag_field)  }
  let(:user){ build(:no_roles_user) }
  let(:taggable){ create(:person) }
  let(:tag_list){ 'tag1, tag2' }
  let(:tag_field){ :skills }
  let(:execution){ ->{ subject.execute } }
  let(:authorization){ ->{ allow(user).to receive( :can_add_tags? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'works given  a comma-separated list of tags' do
        execution.call
        expect( taggable.tags_on(:skills).count ).to eq 2
        expect( taggable.tag_list_on :skills ).to include 'tag1'
        expect( taggable.tag_list_on :skills ).to include 'tag2'
      end
    end

  end

  include_examples 'a form provider'
  include_examples 'a controller commander'

end
