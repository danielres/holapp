require 'spec_helper'

describe HavingAGlobalView do

  context 'given an user with admin role' do
    let(:admin) { User.new.tap{ |u| u.add_role :admin } }
    it 'initializes correctly' do
      context = described_class.new admin
    end
    describe 'having a global view' do
      let(:context) { described_class.new(admin) }
      context('with existing projects') do
        before(:each) do
          Project.create(name: 'project_A')
          Project.create(name: 'project_B')
        end
        it 'displays the rendered list of projects' do
          expect( context.view ).to include 'project_A'
          expect( context.view ).to include 'project_B'
        end
      end
      context('with existing people') do
        before(:each) do
          User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_A')
          User.create!(email: "foo2#{rand}@bar.com", password: 'password', name: 'person_B')
        end
        it 'displays the rendered list of people' do
          expect( context.view ).to include 'person_A'
          expect( context.view ).to include 'person_B'
        end
      end
  end
  end

end
