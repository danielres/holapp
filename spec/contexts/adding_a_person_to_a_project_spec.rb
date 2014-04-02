require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPersonToAProject do
  subject{ described_class.new(user, person, project)  }
  let(:user){ build(:no_roles_user) }
  let(:person){ build(:person) }
  let(:project){ build(:project) }
  let(:execution){ ->{ subject.execute } }
  let(:authorization){ ->{ allow(user).to receive( :can_manage_memberships? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'works' do
        execution.call
        expect( project.members ).to match_array [person]
      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander'

end

