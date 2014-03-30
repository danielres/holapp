class ActionForbiddenError < StandardError; end

class AddingAProject

  def initialize(adder)
    @adder = adder
    @adder.extend Adder
  end

  def execute(attributes)
    project = Project.new(random_attributes.merge(attributes))
    @adder.add_project( project,
                       failure: ->{ @controller.try(:failure, project) },
                       success: ->{ @controller.try(:success, project) }, )
  end

  def expose_form(view_context)
    return unless @adder.can_add_project?
    view_context.render(partial: 'contexts/adding_a_project/form')
  end

  def command(controller)
    @controller = controller
  end


  private

    def random_attributes
      { name: "ChangeMe#{rand}" }
    end

    module Adder
      def add_project(project, callbacks = {})
        raise ActionForbiddenError unless can_add_project?
        success?(project) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(project)
        project.save
      end
      def can_add_project?
        Ability.new(self).can? :create, Project
      end
    end

end

