class AddingAPerson

  def initialize(adder, view_context, person_attributes = {})
    @adder = adder
    @view_context = view_context
    @person_attributes = default_person_attributes.merge(person_attributes)
    @adder.extend Adder
  end

  def add
    if @adder.can_add_new_person?
      User.create!(@person_attributes)
    end
  end

  def expose_form
    return '' unless @adder.can_add_new_person?
    h.render(partial: 'contexts/adding_a_person/form')
  end

  private

    def h
      @view_context
    end

    def default_person_attributes
      { email: "changeme#{rand}@changema.com", password: "changeme#{rand}" }
    end

    module Adder
      def can_add_new_person?
        Ability.new(self).can? :create, User
      end
    end

end

