require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe DestroyingADuration do

  context 'given a user and a duration' do
    subject{ described_class.new(user, duration)  }
    let(:user){ build(:no_roles_user) }
    let(:duration){ Duration.create}
    let(:execution){ ->{ subject.execute } }
    let(:authorization){ ->{ allow(user).to receive( :can_destroy_resource? ){ true } } }

    describe 'execution' do

      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'destroys the duration' do
          expect{ execution.call }
            .to change{ Duration.count }
            .from(1)
            .to(0)
        end
      end

      include_examples 'a controller commander', :destroy_success, :destroy_failure

    end

  end

end
