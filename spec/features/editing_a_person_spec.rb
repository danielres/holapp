include Warden::Test::Helpers
Warden.test_mode!

def admin_user
  User.create!(email: "admin#{rand}@user.com", password: 'password', name: 'Admin#{rand}').tap do |u|
    u.confirm!
    u.add_role :admin
  end
end

describe 'Editing a person' do
  let!(:person){ User.create!(email: "person@person.com", password: 'password', name: 'Visitor') }
  let!(:project){ Project.create!(name: 'Project1') }
  context 'when authenticated' do

    describe 'using the membership form to add the person to a project' do
      before(:each) do
        login_as(admin_user, scope: :user)
        visit person_path(person)
        within 'form.new_membership' do
          page.select(project.name)
          page.find('input[type=submit]').click
        end
      end
      it %q[adds the project on the person's page] do
        within '[data-purpose=memberships-list]' do
          expect( page ).to have_content 'Project1'
        end
      end
    end
  end
end


