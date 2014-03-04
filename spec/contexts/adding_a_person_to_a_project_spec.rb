require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require_relative 'shared_examples_for_form_providers'
require_relative 'shared_examples_for_controller_commanders'

describe AddingAPersonToAProject do
  subject{ described_class.new(adder, person, project, view_context)  }
  let(:person){ create(:person) }
  let(:project){ create(:project) }

  context 'by a guest user' do
    let(:adder){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.add }.to raise_error ActionForbiddenError
    end
  end

  context 'by a superuser' do
    let(:adder){ create(:super_user) }
    it 'is supported' do
      subject.add
      expect( project.members ).to match_array [person]
    end

    describe 'performing' do
      let(:performer){ adder }
      let(:perform){ ->{ subject.add } }
      include_examples 'a controller commander'
    end

  end

  include_examples 'a form provider', 'form.new_membership'

end

