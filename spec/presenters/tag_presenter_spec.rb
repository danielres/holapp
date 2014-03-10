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
      let(:tag){ build(:tag, name: 'Tag name') }
      let(:view_context){ view }
      it 'presents the tag' do
        expect( fragment subject.to_html ).to have_content('Tag name')
      end
    end
  end

end
