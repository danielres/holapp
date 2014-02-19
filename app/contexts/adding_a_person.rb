class AddingAPerson

  def initialize(adder, person_attributes)
    @adder = adder
    @person_attributes = person_attributes
    @adder.extend Adder
  end

  def add
    if @adder.can_add_new_person?
      User.create!(@person_attributes)
    end
  end

  private

    module Adder
      def can_add_new_person?
        Ability.new(self).can? :create, User
      end
    end

end

