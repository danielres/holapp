require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'

describe AddingAPerson do
  subject{ described_class.new(adder, view_context) }
  let(:added_person_attrs){ { name: 'Toto'} }


  context 'by a guest user' do
    let(:adder){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.add(added_person_attrs) }.to raise_error ActionForbiddenError
    end
    describe 'form' do
      it 'is not exposed' do
        expect( fragment(subject.expose_form) ).not_to have_css 'form.new_user'
      end
    end
  end


  context 'by a superuser' do
    let(:adder){ create(:super_user) }
    it "is supported given just a name" do
      subject.add(added_person_attrs)
      expect( User.last.name ).to eq 'Toto'
    end
    describe 'form' do
      it 'is exposed' do
        expect( fragment(subject.expose_form) ).to have_css 'form.new_user'
      end
    end
    describe 'on success and failure' do
      let(:controller){ double('controller') }
      before(:each){ subject.command(controller) }
      it 'commands the controller accordingly' do
        expect(controller).to receive(:success)
        subject.add(added_person_attrs)
        expect(controller).to receive(:failure)
        subject.add(added_person_attrs)
      end
    end
  end


end
