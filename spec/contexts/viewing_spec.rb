require 'spec_helper'

describe Viewing do

  describe 'initialization' do
    context 'given a spectator, a type and a presenter' do
      let(:spectator){ User.new }
      let(:type){ Class.new }
      let(:presenter_type){ Class.new }
      it 'initializes correctly' do
        described_class.new(spectator, type, presenter_type)
      end
    end
  end

  describe 'viewing projects' do
    let(:viewing){ Viewing.new(spectator, type, presenter)  }
    let(:type){ Project }
    let(:presenter){ ProjectsPresenter }
    before(:each) do
      Project.create!(name: 'project_1')
      Project.create!(name: 'project_2')
    end
    context 'as a simple user' do
      let(:spectator){ User.new }
      it 'does not reveal the projects' do
        expect( viewing.reveal ).not_to include 'project_1'
        expect( viewing.reveal ).not_to include 'project_2'
      end
    end
    context 'as an admin user' do
      let(:spectator){ User.new.tap{ |u| u.add_role :admin } }
      it 'reveals the projects' do
        expect( viewing.reveal ).to include 'project_1'
        expect( viewing.reveal ).to include 'project_2'
      end
    end
  end

  describe 'viewing people' do
    let(:viewing){ Viewing.new(spectator, type, presenter)  }
    let(:type){ User }
    let(:presenter){ PeoplePresenter }
    before(:each) do
      User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_1')
      User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_2')
    end
    context 'as a simple user' do
      let(:spectator){ User.new }
      it 'does not reveal the people' do
        expect( viewing.reveal ).not_to include 'person_1'
        expect( viewing.reveal ).not_to include 'person_2'
      end
    end
    context 'as an admin user' do
      let(:spectator){ User.new.tap{ |u| u.add_role :admin } }
      it 'reveals the people' do
        expect( viewing.reveal ).to include 'person_1'
        expect( viewing.reveal ).to include 'person_2'
      end
    end
  end


end
