require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe ProjectPresenter do

  describe 'rendering to html' do
    subject{ described_class.new(viewer, project, view_context) }
    let(:viewer){ build(:no_roles_user) }
    let(:project){ build(:project, name: 'My project') }
    let(:view_context){ view }
    it 'presents the project' do
      expect( fragment subject.to_html ).to have_content('My project')
    end
  end

end
