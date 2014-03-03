require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'

describe AddingAPersonToAProject do
  subject{ described_class.new(adder, person, project, view_context)  }
  let(:person){ create(:person) }
  let(:project){ create(:project) }


  context 'by a guest user' do
    let(:adder){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.add }.to raise_error ActionForbiddenError
    end
    describe 'form' do
      it 'is not exposed' do
        expect( fragment(subject.expose_form) ).not_to have_css 'form.new_membership'
      end
    end
  end


  context 'by a superuser' do
    let(:adder){ create(:super_user) }
    it 'is supported' do
      subject.add
      expect( project.members ).to match_array [person]
    end
    describe 'form' do
      it 'is exposed' do
        expect( fragment(subject.expose_form) ).to have_css 'form.new_membership'
      end
    end
    describe 'on success and failure' do
      let(:controller){ double('controller') }
      before(:each){ subject.command(controller) }
      it 'commands the controller accordingly' do
        expect(controller).to receive(:success)
        subject.add
        expect(controller).to receive(:failure)
        subject.add
      end
    end
  end


end
