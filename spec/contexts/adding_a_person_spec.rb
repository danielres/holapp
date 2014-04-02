require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPerson do
  subject{ described_class.new(user) }
  let(:user){ build(:no_roles_user) }
  let(:execution){ ->{ subject.execute(added_person_attrs) } }
  let(:added_person_attrs){ { name: 'Alfred Hitchie'} }
  let(:authorization){ ->{ allow(user).to receive( :can_add_person? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
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
