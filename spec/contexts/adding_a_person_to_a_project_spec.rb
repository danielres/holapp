require 'spec_helper'

describe AddingAPersonToAProject do

  describe 'adding a person to a project' do

    let(:adding_a_person_to_a_project){ described_class.new(adder, person, project)  }
    let(:person) do
      User.create!(email: "foo1#{rand}@bar.com", password: 'password', name: 'User name')
    end
    let(:project){ Project.create!(name: 'Project') }

    before(:each) do
      adding_a_person_to_a_project.add
    end

    context 'as a guest user' do
      let(:adder){ User.new }
      it 'does not add the person to the project' do
        expect( project.members ).not_to match_array [person]
      end
    end
    context 'as an authorized adder' do
      let(:any_authorized_role){ :admin }
      let(:adder){ User.new.tap{ |u| u.add_role(any_authorized_role) } }
      it 'adds the person to the project' do
        expect( project.members ).to match_array [person]
      end
    end
  end

end
