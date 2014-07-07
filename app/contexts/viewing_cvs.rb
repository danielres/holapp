class ViewingCvs

  include IsAnAdvancedCallable
  include SetsAViewContext
  include UsesAPresenter

  def initialize(user, people)
    @user       = user
    @collection = people
  end

  private

    def authorized?
      Ability.new(@user).can? :read, User
    end

    def presenter
      ->{ CvsPresenter.new(collection: @collection, view_context: @view_context ).to_html }
    end

    def journal_event
      #todo
    end

end


