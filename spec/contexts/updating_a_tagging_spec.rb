require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingATagging do

  context 'given a user and a tagging' do
    subject{ described_class.new(user, tagging)  }
    let(:user) { double('user') }
    let(:tagging){ Tagging.create!( description: 'initial_description' ) }

    context 'by a guest user' do
      let(:user){ build(:no_roles_user) }
      it 'is forbidden' do
        expect{ subject.update(anything) }.to raise_error ActionForbiddenError
      end
    end

    context 'by a superuser' do
      let(:user){ create(:super_user) }
      let(:desired_attributes) { { description: 'desired_description' } }
      it 'supports updating the tagging description' do
        expect{ subject.update(desired_attributes) }
          .to change{ tagging.description }
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
