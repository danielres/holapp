require 'spec_helper'
require 'factories_spec_helper'

describe ViewingPeople do
  subject{ described_class.new(user) }

  describe 'people list' do
    let(:view_context){ double('view_context') }
    let!(:person){ create(:person) }

    context 'for guest users' do
      let(:user){ build(:no_roles_user) }
      it 'renders no people' do
        expect( view_context ).to receive(:render) do |options|
          expect(options[:locals][:people]).to be_empty
        end
        subject.expose_list(view_context)
      end
    end

    context 'for super users' do
      let(:user){ create(:super_user) }
      it 'renders the people' do
        expect( view_context ).to receive(:render) do |options|
          expect(options[:locals][:people]).to match_array [ person, user]
        end
        subject.expose_list(view_context)
      end
    end

  end

end
