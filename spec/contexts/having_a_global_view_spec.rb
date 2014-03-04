require 'spec_helper'
require 'factories_spec_helper'

describe HavingAGlobalView do

  subject{ described_class.new(viewer, view_context) }
  let(:viewer){ create(:super_user) }
  let(:view_context){ double('view_context') }

  describe 'having a global view' do
    let!(:project){ create( :project, name: 'Project 1') }
    let(:projects){ [ project  ] }
    let(:people){ [ viewer ] }
    it 'renders projects and people' do
      expect( view_context )
        .to receive(:render)
        .with hash_including( locals: { projects: projects } )
      expect( view_context )
        .to receive(:render)
        .with hash_including( locals: { people: people }  )
      subject.view
    end

  end

end
