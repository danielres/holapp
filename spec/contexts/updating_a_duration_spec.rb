require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingADuration do

  context 'given a user and a duration' do
    subject{ described_class.new(user, duration)  }
    let(:user){ build(:no_roles_user) }
    let(:duration){ Duration.new }
    let(:execution){ ->{ subject.execute(desired_attributes) } }
    let(:authorization){ ->{ allow(user).to receive( :can_update_resource? ){ true } } }

    describe 'execution' do
      let(:desired_attributes) { { starts_at: "2013-06-10", ends_at: "2014-06-11"  } }
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'supports updating the duration start time' do
          expect{ execution.call }
            .to change{ duration.starts_at }
            .from( nil )
            .to("2013-06-10")
        end
        it 'supports updating the duration end time' do
          expect{ execution.call }
            .to change{ duration.ends_at }
            .from( nil )
            .to("2014-06-11")
        end
      end

      include_examples 'a controller commander', :update_success, :update_failure

    end

  end

end
