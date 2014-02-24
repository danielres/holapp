require 'spec_helper'
require 'view_context_spec_helper'


def build_admin_user
  User.new.tap{ |u| u.add_role(:admin) }
end


describe AddingAProject do

  let(:adding_a_project){ described_class.new(adder, view_context)  }
  let(:project_attributes){ { name: 'My project'} }

  context 'as a guest user' do

    let(:adder){ User.new }

    describe 'exposing the form' do
      it 'does not render the form' do
        node = Capybara.string(adding_a_project.expose_form.to_s)
        expect( node ).not_to have_css 'form.new_project'
      end
    end

    describe 'adding a project' do
      it 'does not allow the operation to complete' do
        adding_a_project.add(project_attributes) rescue ActionForbiddenError
      end
    end

  end

  context 'as an authorized adder' do

    let(:adder){ build_admin_user }

    describe 'exposing the form' do
      it 'renders the form' do
        node = Capybara.string(adding_a_project.expose_form)
        expect( node ).to have_css 'form.new_project'
      end
    end

    describe 'adding a project' do
      context "given only the project's name" do
        it 'adds the project' do
          adding_a_project.add(project_attributes)
          expect( Project.last.name ).to eq 'My project'
        end
      end
    end

    context 'commanding the controller' do
      let(:controller){ double('controller') }
      before(:each) do
        adding_a_project.command(controller)
      end
      describe 'on success and on failure' do
        it 'commands the controller accordingly' do
          expect(controller).to receive(:success); adding_a_project.add(project_attributes)
          expect(controller).to receive(:failure); adding_a_project.add(project_attributes)
        end
      end
    end

  end

end
