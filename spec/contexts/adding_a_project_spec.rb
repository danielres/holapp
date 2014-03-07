require 'spec_helper'
require 'factories_spec_helper'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAProject do
  subject{ described_class.new(user)  }
  let(:project_attributes){ { name: 'My project'} }


  context 'by a guest user' do
    let(:user){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.add(project_attributes) }.to raise_error ActionForbiddenError
    end
  end


  context 'by a superuser' do
    let(:user){ create(:super_user) }
    it "is supported given just a name" do
      subject.add(project_attributes)
      expect( Project.last.name ).to eq 'My project'
    end

    describe 'performing' do
      let(:perform){ ->{ subject.add(project_attributes) } }
      include_examples 'a controller commander'
    end

  end

  include_examples 'a form provider'

end
