require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAMembership do

  context 'given a user and a membership' do
    subject{ described_class.new(user, membership)  }
    let(:user) { double('user') }
    let(:project){ create(:project) }
    let(:person){ create(:person) }
    let(:membership){ Membership.create!( description: 'initial_description', user_id: person.id, project_id: project.id) }

    context 'by a guest user' do
      let(:user){ build(:no_roles_user) }
      it 'is forbidden' do
        expect{ subject.update(anything) }.to raise_error ActionForbiddenError
      end
    end

    context 'by a superuser' do
      let(:user){ create(:super_user) }
      let(:desired_attributes) { { description: 'desired_description' } }
      it 'supports updating the membership description' do
        expect{ subject.update(desired_attributes) }
          .to change{ membership.description }
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
