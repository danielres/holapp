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


describe 'Adding a project' do
  context 'when authenticated' do

    describe 'using the form to add a project' do
      before(:each) do
        login_as(admin_user, scope: :user)
        visit '/'
        within 'form.new_project' do
          page.fill_in :project_name, with: 'My cool project'
          page.find('input[type=submit]').click
        end
      end
      it %q[adds the project to the list of projects] do
        within the('projects-list') do
          expect( page ).to have_content 'My cool project'
        end
      end
    end
  end
end


