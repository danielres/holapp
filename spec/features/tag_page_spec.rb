require 'spec_helper'
require 'fast_authentication_spec_helper'
require 'factories_spec_helper'
require 'purpose_selector_spec_helper'

describe 'Tag page' do
  let(:tag){ create(:tag) }


  context 'for a superuser' do
    let(:user){ create(:super_user) }
    before(:each) do
      login_as(user, scope: :user)
    end

    describe 'presenting the tag data' do
      before(:each) do
        tag.update_attributes(name: 'the name', description: 'the description')
        visit tag_path(tag)
      end
      subject{ page }
      it 'presents the name' do
        expect( page ).to have_content 'the name'
      end
      it 'presents the description' do
        expect( page ).to have_content 'the description'
      end

    end

    describe 'presenting the tagged elements' do
      context 'when applied to a people and projects' do
        let!(:person){ create(:person) }
        let!(:project){ create(:project) }
        before(:each) do
          CreatingTaggings.new(user, person, 'skill1', :skills).tag
          CreatingTaggings.new(user, project, 'skill1', :skills).tag
          tag = Tag.find_by_name('skill1')
          visit tag_path(tag)
        end
        it 'presents the links to the tagged people and projects' do
          within the 'projects-list' do
            expect( page ).to have_content project.name
          end
          within the 'people-list' do
            expect( page ).to have_content person.name
          end
        end
      end
    end

  end

end
