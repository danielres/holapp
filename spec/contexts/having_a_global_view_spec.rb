require 'spec_helper'

describe HavingAGlobalView do

  context 'given a user' do
    let(:user) { double('user') }
    it 'initializes correctly' do
      context = described_class.new user
    end
    describe 'having a global view' do
      context('with existing projects') do
        let(:context) { described_class.new(user) }
        before(:each) do
        Project.create(name: 'project_A')
        Project.create(name: 'project_B')
        end
        it 'displays the rendered list of projects' do
          expect( context.view ).to include 'project_A'
          expect( context.view ).to include 'project_B'
        end
      end
  end
  end

end
