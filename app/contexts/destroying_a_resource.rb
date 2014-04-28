class DestroyingAResource

  def initialize(destroyer, resource)
    @destroyer = destroyer
    @resource = resource
    @destroyer.extend Destroyer
  end

  def execute
    @destroyer.destroy_resource(@resource,
                      failure: ->{ @controller.try(:destroy_failure, @resource) },
                      success: ->{ @controller.try(:destroy_success, @resource) }, )
  end

  def command(controller)
    @controller = controller
  end

  private

    module Destroyer
      def destroy_resource(resource, callbacks = {})
        raise ActionForbiddenError unless can_destroy_resource?(resource)
        success?(resource) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(resource)
        resource.destroy
      end
      def can_destroy_resource?(resource)
        Ability.new(self).can? :destroy, resource
      end
    end

end

