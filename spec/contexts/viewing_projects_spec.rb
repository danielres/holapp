require 'spec_helper'

describe ViewingProjects do

  context 'given a user' do
    let(:user) { User.new }
    it 'initializes correctly' do
      context = described_class.new user
    end
    describe 'viewing existing projects' do
      let(:context) { described_class.new(user) }
      before(:each) do
        Project.create(name: 'project_1')
        Project.create(name: 'project_2')
      end
      context 'when user is allowed' do
        before(:each) do
          allow(user).to receive(:has_role?){ true }
        end
        it 'renders the collection of projects' do
          expect( context.view ).to include 'project_1'
          expect( context.view ).to include 'project_2'
        end
      end
      context 'when user is not allowed' do
        before(:each) do
          allow(user).to receive(:has_role?){ false }
        end
        it 'does not render the collection' do
          expect( context.view ).not_to include 'project_1'
          expect( context.view ).not_to include 'project_2'
        end
      end
    end
  end

end
