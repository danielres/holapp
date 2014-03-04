shared_examples 'a form provider' do

  describe 'form' do

    context 'for guest users' do
      let(:adder){ build(:no_roles_user) }
      it 'is not exposed' do
        expect( view_context ).not_to receive(:render)
        subject.expose_form
      end
    end

    context 'for super users' do
      let(:adder){ create(:super_user) }
      it 'is exposed' do
        expect( view_context ).to receive(:render)
        subject.expose_form
      end
    end

  end

end
