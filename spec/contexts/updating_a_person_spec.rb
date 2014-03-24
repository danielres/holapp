require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAPerson do

  context 'given a user and a person' do
    subject{ described_class.new(user, person)  }
    let(:user) { double('user') }
    let(:person){ create(:person, first_name: 'initial_firstname', last_name: 'initial_lastname', description: 'initial_description') }

    context 'by a guest user' do
      let(:user){ build(:no_roles_user) }
      it 'is forbidden' do
        expect{ subject.update(anything) }.to raise_error ActionForbiddenError
      end
    end

    context 'by a superuser' do
      let(:user){ create(:super_user) }
      let(:desired_attributes) { { first_name: 'desired_firstname', last_name: 'desired_lastname', description: 'desired_description' } }
      it 'supports updating the person name' do
        expect{ subject.update(desired_attributes) }
          .to change{ person.name }
          .from('initial_firstname')
          .to('desired_firstname')
      end
      it 'supports updating the person description' do
        expect{ subject.update(desired_attributes) }
          .to change{ person.description }
          .from('initial_description')
          .to('desired_description')
      end
      describe 'performing' do
        let(:perform){ ->{ subject.update(desired_attributes) } }
        include_examples 'a controller commander', :update_success, :update_failure
      end
    end


  end

end
