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
      allow( view_context ).to receive(:render)
      expect( view_context ).to receive(:render) do |options|
        expect( options[:locals][:projects] ).to match_array projects
      end
      expect( view_context ).to receive(:render) do |options|
        expect( options[:locals][:people] ).to match_array people
      end
      subject.view(view_context)
    end

  end

end
