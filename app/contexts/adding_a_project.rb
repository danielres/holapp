class ActionForbiddenError < StandardError; end

class AddingAProject

  def initialize(adder, view_context)
    @adder = adder
    @view_context = view_context
    @adder.extend Adder
  end

  def add(attributes)
    project = Project.new(random_attributes.merge(attributes))
    @adder.add_project( project,
                       failure: ->{ @controller.try(:failure, project) },
                       success: ->{ @controller.try(:success, project) }, )
  end

  def expose_form
    return unless @adder.can_add_project?
    h.render(partial: 'contexts/adding_a_project/form')
  end

  def command(controller)
    @controller = controller
  end


  private

    def h
      @view_context
    end

    def random_attributes
      { name: "ChangeMe#{rand}" }
    end

    module Adder
      def add_project(project, callbacks = {})
        raise ActionForbiddenError unless can_add_project?
        project.save ? callbacks[:success].call : callbacks[:failure].call
      end
      def can_add_project?
        Ability.new(self).can? :create, Project
      end
    end

end

