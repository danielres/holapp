require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'


describe 'Editing a person' do
  let(:super_user){ create(:super_user) }

  let!(:person){ create(:person) }
  let!(:project){ create(:project, name: 'Project name') }
  context 'as a superuser' do

    describe 'adding the person to a project' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit person_path(person)
        within 'form.new_membership' do
          page.select(project.name)
          page.find('button[type=submit]').click
        end
      end
      it %q[mentions the project on the person's page] do
        within the('memberships-list') do
          expect( page ).to have_content 'Project name'
        end
      end
    end
  end
end


