require 'spec_helper'
require 'view_context_spec_helper'


def build_admin_user
  User.new.tap{ |u| u.add_role(:admin) }
end
def create_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end


describe HavingAGlobalView do

  let(:authorized_viewer){ build_admin_user }

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
        create_random_person name: 'person_A'
        create_random_person name: 'person_B'
      end

      it 'displays the rendered list of people' do
        expect( subject.view ).to include 'person_A'
        expect( subject.view ).to include 'person_B'
      end
    end
  end

end
