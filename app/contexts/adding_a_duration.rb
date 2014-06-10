class AddingADuration < AddingAResource

 def initialize(adder, durable)
    @adder = adder
    @durable = durable
    @adder.extend AddingAResource::Adder
  end

  def execute
    resource = new_resource(durable_id: @durable.id, durable_type: @durable.class.name.to_s)
    @adder.add_resource( resource,
                       create_failure: ->{ @controller.try(:create_failure) },
                       create_success: ->{ @controller.try(:create_success) }, )
  end


  private

    def context_name
      'adding_a_duration'
    end

    def new_resource(attributes={})
      Duration.new(attributes)
    end

    def render_form_attributes
      { partial: 'contexts/adding_a_duration/form', locals: { durable: @durable } }
    end

end
