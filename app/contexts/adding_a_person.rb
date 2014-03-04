class ActionForbiddenError < StandardError; end

class AddingAPerson

  def initialize(adder, view_context)
    @adder = adder
    @view_context = view_context
    @adder.extend Adder
  end

  def add(attributes)
    person = User.new(random_attributes.merge(attributes))
    @adder.add_person( person,
                       failure: ->{ @controller.try(:failure, person) },
                       success: ->{ @controller.try(:success, person) }, )
  end

  def expose_form
    return unless @adder.can_add_person?
    h.render(partial: 'contexts/adding_a_person/form')
  end

  def command(controller)
    @controller = controller
  end


  private

    def h
      @view_context
    end

    def random_attributes
      { email: "ChangeMe#{rand}@changeme.com", password: "password#{rand}" }
    end

    module Adder
      def add_person(person, callbacks = {})
        raise ActionForbiddenError unless can_add_person?
        success?(person) ? callbacks[:success].call : callbacks[:failure].call
      end
      def success?(person)
        person.save
      end
      def can_add_person?
        Ability.new(self).can? :create, User
      end
    end

end

