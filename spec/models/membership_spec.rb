require 'spec_helper'


def create_random_person options={}
  options = { email: "foo1#{rand}@bar.com", password: 'password', name: 'User name'}.merge options
  User.create!(options)
end


describe Membership do
  context 'given a project and a person' do
    let!(:project){ Project.create! }
    let!(:person) { create_random_person }
    it 'initializes correctly' do
      described_class.new(project: project, user: person)
    end

    describe 'validations' do
      let(:attrs) do
        { project: project, user: person }
      end
      let!(:membership){ Membership.create!(attrs) }
      let(:duplicate_membership){ Membership.new(attrs) }
      it "requires the project-person association to be unique" do
        expect( duplicate_membership.errors_on :project_id ).to include 'has already been taken'
      end
    end

  end
end
