require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'

describe 'Editing a project' do
  let!(:project){ create(:project) }

  context 'as a superuser' do
    let(:super_user){ create(:super_user) }

    before(:each) do
      login_as(super_user, scope: :user)
    end

    describe 'adding the project to a person' do
      let!(:person){ create(:person, name: "Person's name") }
      before(:each) do
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

    describe 'updating the project description', js: true do
      before(:each) do
        project.update(description: 'description')
        visit project_path(project)
      end
      it 'updates the description on the project page' do
        edit_in_place_textarea(project, :description, 'updated description')
        visit project_path(project)
        expect( page ).to have_content('updated description')
      end
    end

    describe 'adding skills' do
      before(:each) do
        visit project_path(project)
      end
      it 'adds the skills to the project page' do
        within the('skills-adder') do
          fill_in :tagging_tag_list, with: 'skill1, skill2'
          first('[type=submit]').click
        end
        visit project_path(project)
        expect( page ).to have_content('skill1')
        expect( page ).to have_content('skill2')
      end
    end

  end

end


