class HavingAGlobalView
  def initialize(user)
    @user = user
  end
  def view(view_context)
    GlobalViewPresenter.new(@user, view_context).as_html
  end

  private

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
          ViewingEntries.new(@user, @view_context, Project, ProjectsPresenter).reveal
        end
        def people_html
          ViewingEntries.new(@user, @view_context, User, PeoplePresenter).reveal
        end
        def top_motivations_html
          '<section>Top motivations</section>' # TODO: add top motivations list
        end
        def top_skills_html
          '<section>Top skills</section>' # TODO: add top skills list
        end
    end

end
