shared_examples 'a form provider' do

  describe 'form' do
    let(:view_context){ double('view_context') }

    context 'with a basic user' do
      it 'is not exposed' do
        expect( view_context ).not_to receive(:render)
        subject.gather_user_input(view_context)
      end
    end

    context 'with an authorized user' do
      before(:each) do
        authorization.call
      end
      it 'is exposed' do
        expect( view_context ).to receive(:render)
        subject.gather_user_input(view_context)
      end
    end

  end

end
