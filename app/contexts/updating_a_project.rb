require 'project'

class UpdatingAProject

  def initialize(user, project, attributes = {})
    @updater = user
    @project = project
    @attributes = attributes
    @project.extend UpdatableProject
  end

  def update
    @project.update_with(@attributes)
  end

  private

    module UpdatableProject
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end
end
