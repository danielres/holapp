require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'

def admin_user
  User.create!(email: "admin#{rand}@user.com", password: 'password', name: 'Admin#{rand}').tap do |u|
    u.confirm!
    u.add_role :admin
  end
end
def create_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end


describe 'Editing a person' do
  let!(:person){ create_random_person }
  let!(:project){ Project.create!(name: 'Project1') }
  context 'when authenticated' do

    describe 'using the membership form to add the person to a project' do
      before(:each) do
        login_as(admin_user, scope: :user)
        visit person_path(person)
        within 'form.new_membership' do
          page.select(project.name)
          page.find('button[type=submit]').click
        end
      end
      it %q[adds the project on the person's page] do
        within the('memberships-list') do
          expect( page ).to have_content 'Project1'
        end
      end
    end
  end
end


