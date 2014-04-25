class AddingAResource

  def initialize(adder)
    @adder = adder
    @adder.extend Adder
  end

  def command(controller)
    @controller = controller
  end

  def gather_user_input(view_context)
    return unless @adder.can_add_resource?(new_resource)
    view_context.render( render_form_attributes )
  end

  def execute(attributes)
    resource = new_resource(attributes)
    @adder.add_resource( resource,
                       create_failure: ->{ @controller.try(:create_failure, resource) },
                       create_success: ->{ @controller.try(:create_success, resource) }, )
  end


  private

    def context_name
      raise NotImplementedError
    end

    def new_resource
      raise NotImplementedError
    end

    def render_form_attributes
      { partial: "contexts/#{ context_name }/form" }
    end

    def random_val
      (rand * 10000).to_i
    end

    module Adder
      def add_resource(resource, callbacks = {})
        raise ActionForbiddenError unless can_add_resource?(resource)
        success?(resource) ? callbacks[:create_success].call : callbacks[:create_failure].call
      end
      def success?(resource)
        resource.save
      end
      def can_add_resource?(resource)
        Ability.new(self).can? :create, resource.class.name
      end
    end

end

