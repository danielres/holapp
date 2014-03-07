require 'spec_helper'
require 'factories_spec_helper'
require 'view_context_spec_helper'

describe ViewingEntries do

  describe 'initialization' do
    context 'given a viewer, a view_context, a type of entries and a presenter' do
      let(:viewer){ User.new }
      let(:type){ Class.new }
      let(:presenter){ Class.new }
      it 'initializes correctly' do
        described_class.new(viewer, view_context, type, presenter)
      end
    end
  end

  describe 'viewing projects' do

    let(:subject){ ViewingEntries.new(viewer, view_context, type, presenter)  }
    let(:type){ Project }
    let(:presenter){ ProjectsPresenter }

    before(:each) do
      Project.create!(name: 'project_1')
      Project.create!(name: 'project_2')
    end

    context 'as a guest viewer' do
      let(:viewer){ build(:no_roles_user) }
      it 'does not reveal the projects' do
        expect( subject.reveal ).not_to include 'project_1'
        expect( subject.reveal ).not_to include 'project_2'
      end
    end

    context 'as an authorized viewer' do
      let(:any_authorized_role){ :admin }
      let(:viewer){ create(:super_user) }
      it 'reveals the projects' do
        expect( subject.reveal ).to include 'project_1'
        expect( subject.reveal ).to include 'project_2'
      end
    end

  end


  describe 'viewing people' do

    let(:subject){ ViewingEntries.new(viewer, view_context, type, presenter)  }
    let(:type){ User }
    let(:presenter){ PeoplePresenter }

    before(:each) do
      create(:person, name: 'person_1')
      create(:person, name: 'person_2')
    end

    context 'as a guest viewer' do
      let(:viewer){ build(:no_roles_user) }
      it 'does not reveal the people' do
        expect( subject.reveal ).not_to include 'person_1'
        expect( subject.reveal ).not_to include 'person_2'
      end
    end

    context 'as an authorized viewer' do
      let(:viewer){ create(:super_user) }
      it 'reveals the people' do
        expect( subject.reveal ).to include 'person_1'
        expect( subject.reveal ).to include 'person_2'
      end
    end

  end


end
