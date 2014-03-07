shared_examples 'a list provider' do

  describe 'list' do
    let(:view_context){ double('view_context') }

    context 'for guest users' do
      let(:user){ build(:no_roles_user) }
      it 'is not exposed' do
        expect( view_context ).not_to receive(:render)
        subject.expose_list(view_context)
      end
    end

    context 'for super users' do
      let(:user){ create(:super_user) }
      it 'is exposed' do
        expect( view_context ).to receive(:render)
        subject.expose_list(view_context)
      end
    end

  end

end
