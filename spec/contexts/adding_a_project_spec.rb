require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAProject do
  subject{ described_class.new(user)  }
  let(:user){ build(:no_roles_user) }
  let(:desired_project_attributes){ { name: 'My project'} }
  let(:execution){ ->{ subject.execute(desired_project_attributes) } }
  let(:authorization){ ->{ allow(user).to receive( :can_add_project? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'works given a name as unique parameter' do
        execution.call
        expect( Project.last.name ).to eq desired_project_attributes[:name]
      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander'

end
