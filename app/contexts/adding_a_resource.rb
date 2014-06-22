class AddingAResource

  include IsAnAdvancedCallable
  include SetsAViewContext
  include PresentsAForm

  def initialize(user, resource = nil)
    @user     = user
    @resource = resource
  end

  def get_user_input
    present_form
  end

  private

    def authorized?
      Ability.new(@user).can? :create, @resource
    end

    def execution
      @resource.save
    end

    def journal_event
      {
        context:   self,
        user:      @user,
        resource:  @resource,
      }
    end


end
