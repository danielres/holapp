require 'spec_helper'

describe ViewingPeople do

  context 'given a user' do
    let(:user) { User.new }
    it 'initializes correctly' do
      context = described_class.new user
    end
    describe 'viewing existing people' do
      let(:context) { described_class.new(user) }
      before(:each) do
        User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'personA')
        User.create!(email: "foo2#{rand}@bar.com", password: 'password', name: 'personB')
      end
      describe 'authorization' do
        context 'without admin role' do
          it 'prevents the collection of people from rendering' do
            expect( context.view ).not_to include 'personA'
            expect( context.view ).not_to include 'personB'
          end
        end
        context 'with admin role' do
          before(:each) { user.add_role :admin }
          it 'renders the collection of people' do
            expect( context.view ).to include 'personA'
            expect( context.view ).to include 'personB'
          end
        end
      end
    end
  end

end
