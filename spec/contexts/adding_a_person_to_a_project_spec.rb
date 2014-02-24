require 'spec_helper'
require 'view_context_spec_helper'


def build_admin_user
  User.new.tap{ |u| u.add_role(:admin) }
end
def create_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end


describe AddingAPersonToAProject do

  let(:adding_a_person_to_a_project){ described_class.new(adder, person, project, view_context)  }

  describe 'adding a person to a project' do

    let(:person) do
      create_random_person
    end
    let(:project){ Project.create!(name: 'Project') }

    context 'as a guest user' do

      let(:adder){ User.new }

      describe 'exposing the form' do
        it 'does not render the form' do
          node = Capybara.string(adding_a_person_to_a_project.expose_form.to_s)
          expect( node ).not_to have_css 'form.new_membership'
        end
      end

      describe 'adding a person to a project' do
        it 'does not allow the operation to complete' do
          adding_a_person_to_a_project.add rescue ActionForbiddenError
        end
      end

    end

    context 'as an authorized adder' do

      let(:adder){ build_admin_user }

      describe 'exposing the form' do
        it 'renders the form' do
          node = Capybara.string(adding_a_person_to_a_project.expose_form)
          expect( node ).to have_css 'form.new_membership'
        end
      end

      it 'adds the person to the project' do
        adding_a_person_to_a_project.add
        expect( project.members ).to match_array [person]
      end

      context 'commanding the controller' do
        let(:controller){ double('controller') }
        before(:each) do
          adding_a_person_to_a_project.command(controller)
        end
        describe 'on success and on failure' do
          it 'commands the controller accordingly' do
            expect(controller).to receive(:success)
            adding_a_person_to_a_project.add
            expect(controller).to receive(:failure)
            adding_a_person_to_a_project.add
          end
        end
      end

    end


  end

end
