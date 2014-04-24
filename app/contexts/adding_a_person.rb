class AddingAPerson

  def initialize(adder)
    @adder = adder
    @adder.extend Adder
  end

  def execute(attributes)
    person = User.new(random_attributes.merge(attributes).symbolize_keys)
    @adder.add_person( person,
                       create_failure: ->{ @controller.try(:create_failure, person) },
                       create_success: ->{ @controller.try(:create_success, person) }, )
  end

  def expose_form(view_context)
    return unless @adder.can_add_person?
    view_context.render(partial: 'contexts/adding_a_person/form')
  end

  def command(controller)
    @controller = controller
  end


  private

    def random_attributes
      { email: "ChangeMe#{rand}@changeme.com", password: "password#{rand}" }
    end

    module Adder
      def add_person(person, callbacks = {})
        raise ActionForbiddenError unless can_add_person?
        success?(person) ? callbacks[:create_success].call : callbacks[:create_failure].call
      end
      def success?(person)
        person.save
      end
      def can_add_person?
        Ability.new(self).can? :create, User
      end
    end

end

