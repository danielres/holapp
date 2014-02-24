require 'spec_helper'
require 'view_context_spec_helper'

describe ProjectsPresenter do

  describe 'initialization' do
    context 'given a collection and a view_context' do
      let(:projects){ [] }
      it 'initializes correctly' do
        described_class.new(projects, view_context)
      end
    end
  end

  describe 'rendering to html' do
    context 'given projects' do
      let(:project1){ Project.new(name: 'project_A') }
      let(:project2){ Project.new(name: 'project_B') }
      let(:projects){ [ project1, project2] }
      let(:projects_presenter){ described_class.new(projects, view_context) }
      it 'renders html with the projects' do
        expect( projects_presenter.to_html ).to include 'project_A'
        expect( projects_presenter.to_html ).to include 'project_B'
      end
    end
  end


end
