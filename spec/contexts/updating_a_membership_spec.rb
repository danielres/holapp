require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAMembership do

  context 'given a user and a membership' do
    subject{ described_class.new(user, membership)  }
    let(:user){ build(:no_roles_user) }
    let(:membership){ Membership.new( description: 'initial_description') }
    let(:execution){ ->{ subject.execute(desired_attributes) } }
    let(:authorization){ ->{ allow(user).to receive( :can_update_membership? ){ true } } }

    describe 'execution' do
      let(:desired_attributes) { { description: 'desired_description' } }
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
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
