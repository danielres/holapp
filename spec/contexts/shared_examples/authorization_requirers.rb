shared_examples 'an authorization requirer' do

  context 'by a basic user' do
    let(:user){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ subject.call }.to raise_error ActionForbiddenError
    end
  end

  context 'by an authorized user' do
    let(:user){ create(:super_user) }
    it 'is allowed' do
      expect{ subject.call }.not_to raise_error
    end
  end

end
