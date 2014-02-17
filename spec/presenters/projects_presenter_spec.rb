require 'spec_helper'
require 'view_context_spec_helper'

describe ProjectsPresenter do

  let(:view_context){ view }

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
      let(:subject){ described_class.new(projects, view_context) }
      it 'renders html with the projects' do
        expect( subject.as_html ).to include 'project_A'
        expect( subject.as_html ).to include 'project_B'
      end
    end
  end


end
