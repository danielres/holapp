require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe CreatingTaggings do
  subject{ described_class.new(user, taggable, tag_list, tag_field)  }
  let(:taggable){ create(:person) }
  let(:tag_list){ 'tag1, tag2' }
  let(:tag_field){ :skills }
  let(:execution){ ->{ subject.execute } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'
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
