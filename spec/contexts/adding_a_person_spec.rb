require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_context_by_an_authorized_user'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPerson do
  subject{ described_class.new(user) }
  let(:added_person_attrs){ { name: 'Alfred Hitchie'} }
  let(:execution){ ->{ subject.execute(added_person_attrs) } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      include_context 'by an authorized user'
      it 'works given a firstname and lastname as unique parameter' do
        execution.call
        expect( User.last.first_name ).to eq 'Alfred'
        expect( User.last.last_name ).to eq 'Hitchie'
      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander', :create_success, :create_failure

end
