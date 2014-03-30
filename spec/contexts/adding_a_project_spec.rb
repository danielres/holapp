require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAProject do
  subject{ described_class.new(user)  }
  let(:desired_project_attributes){ { name: 'My project'} }
  let(:execution){ ->{ subject.execute(desired_project_attributes) } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'
      it 'works given a name as unique parameter' do
        execution.call
        expect( Project.last.name ).to eq desired_project_attributes[:name]
      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander'

end
