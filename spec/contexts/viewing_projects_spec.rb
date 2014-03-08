require 'spec_helper'
require 'factories_spec_helper'

describe ViewingProjects do
  subject{ described_class.new(user) }

  describe 'projects list' do
    let(:view_context){ double('view_context') }
    let!(:project){ create(:project) }

    context 'for guest users' do
      let(:user){ build(:no_roles_user) }
      it 'renders no projects' do
        expect( view_context ).to receive(:render) do |options|
          expect(options[:locals][:projects]).to be_empty
        end
        subject.expose_list(view_context)
      end
    end

    context 'for super users' do
      let(:user){ create(:super_user) }
      it 'renders the projects' do
        expect( view_context ).to receive(:render) do |options|
          expect(options[:locals][:projects]).to match_array [ project ]
        end
        subject.expose_list(view_context)
      end
    end

  end

end
