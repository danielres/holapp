shared_examples 'a form provider' do

  describe 'form' do
    let(:view_context){ double('view_context') }

    context 'with a basic user' do
      let(:user){ build(:no_roles_user) }
      it 'is not exposed' do
        expect( view_context ).not_to receive(:render)
        subject.expose_form(view_context)
      end
    end

    context 'with an authorized user' do
      let(:user){ create(:super_user) }
      it 'is exposed' do
        expect( view_context ).to receive(:render)
        subject.expose_form(view_context)
      end
    end

  end

end
