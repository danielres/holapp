require 'spec_helper'
require 'factories_spec_helper'

describe HavingAGlobalView do

  subject{ described_class.new(user) }
  let(:user){ create(:super_user) }

  describe 'having a global view' do
    let(:view_context){ double('view_context') }
    let!(:project){ create( :project, name: 'Project 1') }
    let(:projects){ [ project  ] }
    let(:people){ [ user ] }
    it 'renders projects and people' do
      expect( view_context )
        .to receive(:render)
        .with hash_including( locals: { projects: projects } )
      expect( view_context )
        .to receive(:render)
        .with hash_including( locals: { people: people }  )
      subject.view(view_context)
    end

  end

end
