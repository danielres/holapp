require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPerson do
  subject{ described_class.new(user) }
  let(:added_person_attrs){ { name: 'Alfred Hitchie'} }


  context 'by a guest user' do
    let(:user){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.add(added_person_attrs) }.to raise_error ActionForbiddenError
    end
  end


  context 'by a superuser' do
    let(:user){ create(:super_user) }
    it "is supported given just a name" do
      subject.add(added_person_attrs)
      expect( User.last.name ).to eq 'Alfred'
    end

    describe 'performing' do
      let(:perform){ ->{ subject.add(added_person_attrs) } }
      include_examples 'a controller commander'
    end

  end

  include_examples 'a form provider'

end
