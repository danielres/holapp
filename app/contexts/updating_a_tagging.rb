class ActionForbiddenError < StandardError; end

class UpdatingATagging

  def initialize(user, tagging)
    @updater = user
    @tagging = tagging
    @updater.extend Updater
    @tagging.extend UpdatableTagging
  end

  def update(attributes)
    @updater.update_tagging_with(@tagging, attributes,
                      failure: ->{ @controller && @controller.update_failure(@tagging) },
                      success: ->{ @controller && @controller.update_success(@tagging) }, )
  end

  def command(controller)
    @controller = controller
  end

  private

    module Updater
      def update_tagging_with(tagging, attributes, callbacks = {})
        raise ActionForbiddenError unless can_update_tagging?(tagging)
        success?(tagging, attributes) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(tagging, attributes)
        tagging.update_with(attributes)
      end
      def can_update_tagging?(tagging)
        Ability.new(self).can? :manage, tagging
      end
    end


    module UpdatableTagging
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end

end
