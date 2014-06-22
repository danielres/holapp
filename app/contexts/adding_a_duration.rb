class AddingADuration < AddingAResource

 def initialize(user, durable)
    @user     = user
    @durable  = durable
    @resource = Duration.new(durable_id: @durable.id, durable_type: @durable.class.name.to_s)
  end

  def get_user_input
    present_form(durable: @durable)
  end

end
