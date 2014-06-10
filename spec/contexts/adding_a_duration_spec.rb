require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_authorization_requirers'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingADuration do
  subject{ described_class.new(user, durable)  }
  let(:user){ build(:no_roles_user) }
  let(:durable){ Membership.new }
  let(:execution){ ->{ subject.execute } }
  let(:authorization){ ->{ allow(user).to receive( :can_add_resource? ){ true } } }

  describe 'execution' do
    include_examples 'an authorization requirer'

    context 'by an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'works' do
        expect( Duration.count ).to eq 0
        execution.call
        expect( Duration.count ).to eq 1

      end
    end
  end

  include_examples 'a form provider'
  include_examples 'a controller commander', :create_success, :create_failure

end

