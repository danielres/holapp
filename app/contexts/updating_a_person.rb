class ActionForbiddenError < StandardError; end

class UpdatingAPerson

  def initialize(user, person)
    @updater = user
    @person = person
    @updater.extend Updater
    @person.extend UpdatablePerson
  end

  def update(attributes)
    @updater.update_person_with(@person, attributes,
                      failure: ->{ @controller && @controller.update_failure(@person) },
                      success: ->{ @controller && @controller.update_success(@person) }, )
  end

  def command(controller)
    @controller = controller
  end

  private

    module Updater
      def update_person_with(person, attributes, callbacks = {})
        raise ActionForbiddenError unless can_update_person?(person)
        success?(person, attributes) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(person, attributes)
        person.update_with(attributes)
      end
      def can_update_person?(person)
        Ability.new(self).can? :manage, person
      end
    end


    module UpdatablePerson
      def update_with(attributes = {})
        update_attributes(attributes)
      end
    end

end
