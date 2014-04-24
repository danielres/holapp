class UpdatingAMembership

  def initialize(user, membership)
    @updater = user
    @membership = membership
    @updater.extend Updater
    @membership.extend UpdatableMembership
  end

  def execute(attributes)
    @updater.update_membership_with(@membership, attributes,
                      failure: ->{ @controller.try(:update_failure, @membership) },
                      success: ->{ @controller.try(:update_success, @membership) }, )
  end

  def command(controller)
    @controller = controller
  end

  private

    module Updater
      def update_membership_with(membership, attributes, callbacks = {})
        raise ActionForbiddenError unless can_update_membership?(membership)
        success?(membership, attributes) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(membership, attributes)
        membership.update_with(attributes)
      end
      def can_update_membership?(membership)
        Ability.new(self).can? :manage, membership
      end
    end


    module UpdatableMembership
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end

end
