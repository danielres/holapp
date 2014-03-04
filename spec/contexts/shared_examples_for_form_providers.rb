shared_examples 'a form provider' do |form_selector|
  describe 'form' do
    context 'for guest users' do
      let(:adder){ build(:no_roles_user) }
      it 'is not exposed' do
        expect( fragment(subject.expose_form) ).not_to have_css form_selector
      end
    end
    context 'for super users' do
      let(:adder){ create(:super_user) }
      it 'is exposed' do
        expect( fragment(subject.expose_form) ).to have_css form_selector
      end
    end
  end
end
