require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_controller_commanders'

describe UpdatingAProject do

  context 'given a user and a project' do
    subject{ described_class.new(user, project)  }
    let(:user){ build(:no_roles_user) }
    let(:project){ build(:project, name: 'initial_name', description: 'initial_description') }
    let(:execution){ ->{ subject.execute(desired_attributes) } }
    let(:authorization){ ->{ allow(user).to receive( :can_update_resource? ){ true } } }

    describe 'execution' do
      let(:desired_attributes) { { name: 'desired_name', description: 'desired_description' } }
      include_examples 'an authorization requirer'

      context 'by an authorized user' do
        before(:each) do
          authorization.call
        end
        it 'supports updating the project name' do
          expect{ execution.call }
            .to change{ project.name }
            .from('initial_name')
            .to('desired_name')
        end
        it 'supports updating the project description' do
          expect{ execution.call }
            .to change{ project.description }
            .from('initial_description')
            .to('desired_description')
        end
      end

      include_examples 'a controller commander', :update_success, :update_failure

    end

  end

end
