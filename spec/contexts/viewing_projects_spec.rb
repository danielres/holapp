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
      describe 'authorization' do
        context 'without admin role' do
          it 'prevents the collection of projects from rendering' do
            expect( context.view ).not_to include 'project_1'
            expect( context.view ).not_to include 'project_2'
          end
        end
        context 'with admin role' do
          before(:each) { user.add_role :admin }
          it 'renders the collection of projects' do
            expect( context.view ).to include 'project_1'
            expect( context.view ).to include 'project_2'
          end
        end
      end
    end
  end

end
