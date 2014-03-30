require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPersonToAProject do
  subject{ described_class.new(user, person, project)  }
  let(:person){ build(:person) }
  let(:project){ build(:project) }
  let(:execution){ ->{ subject.execute } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'
      it 'works' do
        execution.call
        expect( project.members ).to match_array [person]
      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander'

end

