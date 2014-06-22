class DestroyingAResource

  include IsAnAdvancedCallable

  def initialize(user, resource)
    @user     = user
    @resource = resource
  end

  private

    def authorized?
      Ability.new(@user).can? :destroy, @resource
    end

    def execution
      @resource.destroy
    end

    def journal_event
      {
        context:   self,
        user:      @user,
        resource:  @resource,
      }
    end

end

