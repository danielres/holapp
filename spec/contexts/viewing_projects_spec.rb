require 'spec_helper'

describe ViewingProjects do

  context 'given a user' do
    let(:user) { double('user') }
    it 'initializes correctly' do
      context = described_class.new user
    end
    describe 'viewing existing projects' do
      let(:context) { described_class.new(user) }
      before(:each) do
        Project.create(name: 'project_1')
        Project.create(name: 'project_2')
      end
      it 'renders the collection of projects' do
        expect( context.view ).to include 'project_1'
        expect( context.view ).to include 'project_2'
      end
    end
  end

end
