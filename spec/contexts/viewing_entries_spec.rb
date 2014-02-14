require 'spec_helper'

describe ViewingEntries do

  describe 'initialization' do
    context 'given a viewer, a view_context, a type of entries and a presenter' do
      let(:viewer){ User.new }
      let(:view_context){ double('view_context') }
      let(:type){ Class.new }
      let(:presenter){ Class.new }
      it 'initializes correctly' do
        described_class.new(viewer, view_context, type, presenter)
      end
    end
  end

  describe 'viewing projects' do
    let(:subject){ ViewingEntries.new(viewer, view_context, type, presenter)  }
    let(:view_context){ double('view_context') }
    let(:type){ Project }
    let(:presenter){ ProjectsPresenter }
    before(:each) do
      Project.create!(name: 'project_1')
      Project.create!(name: 'project_2')
    end
    context 'as a guest viewer' do
      let(:viewer){ User.new }
      it 'does not reveal the projects' do
        expect( subject.reveal ).not_to include 'project_1'
        expect( subject.reveal ).not_to include 'project_2'
      end
    end
    context 'as an authorized viewer' do
      let(:any_authorized_role){ :admin }
      let(:viewer){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
      it 'reveals the projects' do
        expect( subject.reveal ).to include 'project_1'
        expect( subject.reveal ).to include 'project_2'
      end
    end
  end

  describe 'viewing people' do
    let(:subject){ ViewingEntries.new(viewer, view_context, type, presenter)  }
    let(:view_context){ double('view_context') }
    let(:type){ User }
    let(:presenter){ PeoplePresenter }
    before(:each) do
      User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_1')
      User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_2')
    end
    context 'as a guest viewer' do
      let(:viewer){ User.new }
      it 'does not reveal the people' do
        expect( subject.reveal ).not_to include 'person_1'
        expect( subject.reveal ).not_to include 'person_2'
      end
    end
    context 'as an authorized viewer' do
      let(:any_authorized_role){ :admin }
      let(:viewer){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
      it 'reveals the people' do
        expect( subject.reveal ).to include 'person_1'
        expect( subject.reveal ).to include 'person_2'
      end
    end
  end


end
