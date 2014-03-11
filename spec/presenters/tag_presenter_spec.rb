require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe TagPresenter do

  describe 'rendering to html' do

    context 'for a superuser' do
      subject{ described_class.new(viewer, tag, view_context) }
      let(:viewer){ create(:super_user) }
      let(:tag){ build(:tag, name: 'skill1') }
      let(:view_context){ view }
      it 'presents the tag' do
        expect( fragment subject.to_html ).to have_content('skill1')
      end

      describe 'presenting the tagged elements' do
        context 'when applied to a people and projects' do
          let!(:person){ create(:person) }
          let!(:project){ create(:project) }
          before(:each) do
            CreatingTaggings.new(viewer, person, 'skill1', :skills).tag
            CreatingTaggings.new(viewer, project, 'skill1', :skills).tag
            tag = Tag.find_by_name('skill1')
          end
          it 'presents the links to the tagged people and projects' do
            expect( fragment subject.to_html ).to have_content person.name
            expect( fragment subject.to_html ).to have_content project.name
            #   within the 'projects-list' do
            #     expect( page ).to have_content project.name
            #   end
            #   within the 'people-list' do
            #     expect( page ).to have_content person.name
            #   end
          end
        end
      end

    end
  end

end
