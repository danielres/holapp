require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'
require 'html_fragment_spec_helper'
require 'purpose_selector_spec_helper'

describe PersonPresenter do

  describe 'rendering to html' do
    subject{ described_class.new(viewer, person, view_context) }
    let(:viewer){ build(:no_roles_user) }
    let(:person){ build(:person, name: 'Person name') }
    let(:view_context){ view }
    it 'presents the person' do
      expect( fragment subject.to_html ).to have_content('Person name')
    end
  end

end
