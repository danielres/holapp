require 'spec_helper'
require 'view_context_spec_helper'


describe ProjectPresenter do

  describe 'initialization' do
    context 'given a viewer, project and a view_context' do
      let(:viewer){ double('viewer') }
      let(:project){ double('project') }
      it 'initializes correctly' do
        described_class.new(viewer, project, view_context)
      end
    end
  end

  describe 'rendering to html' do
    let(:viewer){ User.new }
    let(:project){ Project.new name: 'My project' }
    let(:project_presenter){ described_class.new(viewer, project, view_context) }
    it "renders html containing the project's name" do
      expect( project_presenter.to_html ).to include 'My project'
    end
    describe "membership" do
      it "exposes the project membership form" do
        pending 'todo'
      end
      context 'when the project has already members' do
        it "displays the memberships" do
          pending 'todo'
        end
      end
      end
  end

end
