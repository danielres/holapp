require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'

describe 'Editing a membership', :slow do

  context 'as a superuser' do
    let(:super_user){ create(:super_user) }
    let!(:project){ create(:project) }
    let!(:person){ create(:person) }
    let!(:membership){ Membership.create!( user_id: person.id, project_id: project.id ) }

    before(:each) do
      login_as(super_user, scope: :user)
    end

    describe 'updating the membership description from the project side', js: true do
      before(:all) do
        DatabaseCleaner.clean
      end
      before(:each) do
        membership.update(description: 'initial_description')
        visit project_path(project)
        edit_in_place_textarea(membership, :description, 'updated_description')
      end
      it %q[mentions the updated description on the project page] do
        visit project_path(project)
        within the('memberships-list') do
          expect( page ).to have_content "updated_description"
        end
      end
      it %q[mentions the updated description on the person page] do
        visit person_path(person)
        within the('memberships-list') do
          expect( page ).to have_content "updated_description"
        end
      end
    end

    describe 'updating the membership description from the person side', js: true do
      before(:all) do
        DatabaseCleaner.clean
      end
      before(:each) do
        membership.update(description: 'initial_description')
        visit person_path(person)
        edit_in_place_textarea(membership, :description, 'updated_description')
      end
      it %q[mentions the updated description on the project page] do
        visit project_path(project)
        within the('memberships-list') do
          expect( page ).to have_content "updated_description"
        end
      end
      it %q[mentions the updated description on the person page] do
        visit person_path(person)
        within the('memberships-list') do
          expect( page ).to have_content "updated_description"
        end
      end
    end

  end

end


