require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'


describe 'Editing a project' do
  let(:super_user){ create(:super_user) }

  let!(:project){ create(:project) }
  let!(:person){ create(:person, name: "Person's name") }
  context 'as a superuser' do

    describe 'adding the project to a person' do
      before(:each) do
        login_as(super_user, scope: :user)
        visit project_path(project)
        within 'form.new_membership' do
          page.select(person.name)
          page.find('button[type=submit]').click
        end
      end
      it %q[mentions the person on the project's page] do
        within the('memberships-list') do
          expect( page ).to have_content "Person's name"
        end
      end
    end

  end
end


