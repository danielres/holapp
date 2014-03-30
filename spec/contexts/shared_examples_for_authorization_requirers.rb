shared_examples 'an authorization requirer' do

  context 'by a basic user' do
    let(:user){ build(:no_roles_user) }
    it 'is forbidden' do
      expect{ execution.call }.to raise_error ActionForbiddenError
    end
  end

end
