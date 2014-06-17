require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe TaggingAResource do
  subject{ described_class.new(user, tag, tag_field, resource)  }
  let(:user){ build(:no_roles_user) }
  let(:tag){ build(:tag, name: 'my_tag') }
  let(:tag_field){ :skills }
  let(:resource){ create(:person) }
  let(:execution){ ->{ subject.execute } }
  let(:authorization){ ->{ allow(user).to receive( :can_add_tag_to_resource? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'works given a tag' do
        execution.call
        tagging = Tagging.last
        expect( tagging.tag_id        ).to eq tag.id
        expect( tagging.context       ).to eq tag_field.to_s
        expect( tagging.taggable_id   ).to eq resource.id
        expect( tagging.taggable_type ).to eq resource.class.name
      end
    end

  end

  include_examples 'a form provider'
  include_examples 'a controller commander', :success, :failure

end
