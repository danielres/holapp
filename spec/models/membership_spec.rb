require 'spec_helper'
require 'factories_spec_helper'

describe Membership do

    let!(:project){ build(:project) }
    let!(:person) { build(:person) }
    subject{ described_class.new(project: project, user: person) }
    it 'associates a person with a project' do
      subject.save
      expect( project.members ).to include person
      expect( person.projects ).to include project
    end

    describe 'validations' do
      it 'prevents duplicate memberships' do
        expect( subject ).to validate_uniqueness_of(:project_id).scoped_to(:user_id)
      end
    end

end
