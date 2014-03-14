class GlobalViewPresenter
  def initialize viewer, view_context
    @user = viewer
    @view_context = view_context
  end
  def as_html
    [ projects_html,
      people_html,
      top_motivations_html,
      top_skills_html,
    ].join.html_safe
  end
  private
    def projects_html
      ViewingProjects.new(@user).expose_list(@view_context)
    end
    def people_html
      ViewingPeople.new(@user).expose_list(@view_context)
      # ViewingEntries.new(@user, @view_context, User, PeoplePresenter).reveal
    end
    def top_motivations_html
      '<section><h1>Top motivations</h1></section>' # TODO: add top motivations list
    end
    def top_skills_html
      '<section><h1>Top skills</h1></section>' # TODO: add top skills list
    end
end
