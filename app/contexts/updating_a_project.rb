class UpdatingAProject

  def initialize(user, project)
    @updater = user
    @project = project
    @updater.extend Updater
    @project.extend UpdatableProject
  end

  def execute(attributes)
    @updater.update_project_with(@project, attributes,
                      failure: ->{ @controller.try(:update_failure, @project) },
                      success: ->{ @controller.try(:update_success, @project) }, )
  end

  def command(controller)
    @controller = controller
  end

  private

    module Updater
      def update_project_with(project, attributes, callbacks = {})
        raise ActionForbiddenError unless can_update_project?(project)
        success?(project, attributes) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(project, attributes)
        project.update_with(attributes)
      end
      def can_update_project?(project)
        Ability.new(self).can? :manage, project
      end
    end


    module UpdatableProject
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end

end
