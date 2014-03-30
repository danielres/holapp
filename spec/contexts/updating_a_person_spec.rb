require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAPerson do

  context 'given a user and a person' do
    subject{ described_class.new(user, person)  }
    let(:user) { double('user') }
    let(:person){ build(:person, first_name: 'initial_firstname', last_name: 'initial_lastname', description: 'initial_description') }
    let(:execution){ ->{ subject.execute(desired_attributes) } }

    describe 'execution' do
      let(:desired_attributes) { { first_name: 'desired_firstname', last_name: 'desired_lastname', description: 'desired_description' } }
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        include_context 'by an authorized user'
        it 'supports updating the person name' do
          expect{ execution.call }
            .to change{ person.name }
            .from('initial_firstname')
            .to('desired_firstname')
        end
        it 'supports updating the person description' do
          expect{ execution.call }
            .to change{ person.description }
            .from('initial_description')
            .to('desired_description')
        end
      end

      include_examples 'a controller commander', :update_success, :update_failure

    end

  end

end
