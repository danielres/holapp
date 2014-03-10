require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'purpose_selector_spec_helper'
require 'factories_spec_helper'
require 'best_in_place_spec_helper'
require_relative 'shared_examples_for_taggables_spec'

describe 'Editing a person' do
  let!(:person){ create(:person) }

  context 'as a superuser' do
    let(:super_user){ create(:super_user) }

    before(:each) do
      login_as(super_user, scope: :user)
    end

    describe 'adding the person to a project' do
      let!(:project){ create(:project, name: "Project's name") }
      before(:each) do
        visit person_path(person)
        within 'form.new_membership' do
          page.select(project.name)
          page.find('button[type=submit]').click
        end
      end
      it %q[mentions the project on the person's page] do
        within the('memberships-list') do
          expect( page ).to have_content "Project's name"
        end
      end
    end

    describe 'updating the person description', js: true do
      before(:each) do
        person.update(description: 'description')
        visit person_path(person)
      end
      it 'updates the description on the person page' do
        edit_in_place_textarea(person, :description, 'updated description')
        visit person_path(person)
        expect( page ).to have_content('updated description')
      end
    end

    describe 'tagging' do
      let(:taggable){ person }
      let(:tag_field){ :skills }
      include_examples 'a taggable'
    end

  end

end


