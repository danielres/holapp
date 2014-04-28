require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe DestroyingAMembership do

  context 'given a user and a membership' do
    subject{ described_class.new(user, membership)  }
    let(:user){ build(:no_roles_user) }
    let(:membership){ Membership.create}
    let(:execution){ ->{ subject.execute } }
    let(:authorization){ ->{ allow(user).to receive( :can_destroy_resource? ){ true } } }

    describe 'execution' do

      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'destroys the membership' do
          expect{ execution.call }
            .to change{ Membership.count }
            .from(1)
            .to(0)
        end
      end

      include_examples 'a controller commander', :destroy_success, :destroy_failure

    end

  end

end
