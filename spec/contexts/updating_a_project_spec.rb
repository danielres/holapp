require 'spec_helper'
require 'updating_a_project'

describe UpdatingAProject do

  context 'given a user and a project' do
    let(:user) { double('user') }
    let(:project){ Project.new(name: 'initial_name') }
    it 'initializes correctly' do
      context = described_class.new user, project
    end
    describe 'updating a project' do
      context 'given desired attributes' do
        let(:desired_attributes) { { name: 'desired_name' } }
        let(:context) { described_class.new(user, project, desired_attributes) }
        it 'updates the project accordingly' do
          expect{ context.update }.to change{ project.name }.from('initial_name').to('desired_name')
        end
      end
    end
  end

end
