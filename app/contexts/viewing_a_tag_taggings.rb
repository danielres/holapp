class ViewingATagTaggings

  include IsAnAdvancedCallable
  include SetsAViewContext
  include UsesAPresenter

  attr_writer :collection

  def initialize(user, tag)
    @user       = user
    @tag        = tag
  end

  private

    def authorized?
      Ability.new(@user).can? :read, @tag
    end

    def presenter
      @collection ||= @tag.taggings.accessible_by(Ability.new(@user), :read)
      ->{ TagTaggingsPresenter.new(collection: @collection, view_context: @view_context).to_html }
    end

    def journal_event
      {
        context:    self,
        user:       @user,
        resource:   @resource,
        collection: @collection,
      }
    end

end
