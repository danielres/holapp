require 'spec_helper'

describe HavingAGlobalView do

  let(:any_authorized_role){ :admin }
  let(:authorized_viewer){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
  let(:view_context){ double('view_context') }

  describe 'initialization' do
    context 'given an authorized viewer and a view context' do
      it 'initializes correctly' do
        described_class.new(authorized_viewer, view_context)
      end
    end
  end
  describe 'having a global view' do
    subject{ described_class.new(authorized_viewer, view_context) }
    context('with existing projects') do
      before(:each) do
        Project.create(name: 'project_A')
        Project.create(name: 'project_B')
      end
      it 'displays the rendered list of projects' do
        expect( subject.view ).to include 'project_A'
        expect( subject.view ).to include 'project_B'
      end
    end
    context('with existing people') do
      before(:each) do
        User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'person_A')
        User.create!(email: "foo2#{rand}@bar.com", password: 'password', name: 'person_B')
      end
      it 'displays the rendered list of people' do
        expect( subject.view ).to include 'person_A'
        expect( subject.view ).to include 'person_B'
      end
    end
  end

end
