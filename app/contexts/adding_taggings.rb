class AddingTaggings

  include IsAnAdvancedCallable
  include SetsAViewContext
  include PresentsAForm

  def initialize(user, taggable, tag_list, tag_field)
    @user      = user
    @taggable  = taggable
    @tag_list  = tag_list
    @tag_field = tag_field
  end

  def get_user_input
    present_form(taggable: @taggable, tag_field: @tag_field)
  end

  private

    def authorized?
      Ability.new(@user).can? :manage, @taggable
    end

    def execution
      TagRepository.apply_tag_list_on(@tag_list, @taggable, @tag_field)
    end

    def journal_event
      {
        context:   self,
        user:      @user,
        taggable:  @taggable,
        tag_list:  @tag_list,
        tag_field: @tag_field,
      }
    end

end

