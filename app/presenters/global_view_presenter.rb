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
                          top_motivations: '[TODO]',
                               top_skills: '[TODO]',
                        }
  end
end
