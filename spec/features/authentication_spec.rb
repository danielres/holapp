
describe 'Authentication' do

  describe 'Logging in' do

    let(:visitor) do
      User.create!(email: "visitor@user.com", password: 'password', name: 'Visitor')
    end

    before(:each) do
      visit '/'
      fill_in :user_email, with: 'visitor@user.com'
      fill_in :user_password, with: 'password'
    end

    context 'when visitor has not been confirmed' do
      it 'still offers to log in' do
        click_on 'Log in'
        expect( page ).to have_content 'Log in'
        expect( page ).not_to have_content 'Log out'
      end
    end

    context 'when visitor has been confirmed' do
      before(:each) do
        visitor.confirm!
      end
      it 'displays the contents of the home page' do
        click_on 'Log in'
        expect( page ).to have_content 'Logout'
        expect( page ).not_to have_content 'Log in'
      end
    end

  end

end