module UpdatesAResource

  def with(attributes)
    tap{ @attributes = attributes }
  end

  private
    def authorized?
      Ability.new(@user).can? :manage, @resource
    end

    def execution
      @resource.update_attributes(@attributes)
    end

    def journal_event
      {
        context:    self,
        user:       @user,
        resource:   @resource,
        attributes: @attributes,
      }
    end

end
