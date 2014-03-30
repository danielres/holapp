require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAMembership do

  context 'given a user and a membership' do
    subject{ described_class.new(user, membership)  }
    let(:membership){ Membership.new( description: 'initial_description') }
    let(:execution){ ->{ subject.execute(desired_attributes) } }

    describe 'execution' do
      let(:desired_attributes) { { description: 'desired_description' } }
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        include_context 'by an authorized user'
        it 'supports updating the membership description' do
          expect{ execution.call }
            .to change{ membership.description }
            .from('initial_description')
            .to('desired_description')
        end
      end

      include_examples 'a controller commander', :update_success, :update_failure

    end

  end

end
