class GlobalViewPresenter
  def initialize viewer, view_context
    @user = viewer
    @view_context = view_context
  end
  def as_html
    @view_context.render partial: 'presenters/global_view_presenter',
                         locals: {
                                 projects: ViewingProjects.new(@user).expose_list(@view_context),
                                   people: ViewingPeople.new(@user).expose_list(@view_context),
                             adding_a_person: AddingAPerson.new(@user).gather_user_input(@view_context),
                            adding_a_project: AddingAProject.new(@user).gather_user_input(@view_context),
                          top_motivations: '<p data-purpose="top-motivations">[TODO: top motivations]</p>'.html_safe,
                               top_taggings: ViewingTopTaggings.new(@user).expose_lists(@view_context)
                        }
  end


end
