class UpdatingAResource

  def initialize(updater, resource)
    @updater = updater
    @resource = resource
    @updater.extend Updater
    @resource.extend UpdatableResource
  end

  def execute(attributes)
    @updater.update_resource_with(@resource, attributes,
                      failure: ->{ @controller.try(:update_failure, @resource) },
                      success: ->{ @controller.try(:update_success, @resource) }, )
  end

  def command(controller)
    @controller = controller
  end


  private

    module Updater
      def update_resource_with(resource, attributes, callbacks = {})
        raise ActionForbiddenError unless can_update_resource?(resource)
        success?(resource, attributes) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(resource, attributes)
        resource.update_with(attributes)
      end
      def can_update_resource?(resource)
        Ability.new(self).can? :manage, resource
      end
    end

    module UpdatableResource
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end

end

