class HavingAGlobalView
  def initialize(viewing_user, view_context)
    @viewer = viewing_user
    @view_context = view_context
  end
  def view
    GlobalViewPresenter.new(@viewer).as_html
  end

  private

    class GlobalViewPresenter
      def initialize viewer
        @viewer = viewer
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
          ViewingEntries.new(@viewer, @view_context, Project, ProjectsPresenter).reveal
        end
        def people_html
          ViewingEntries.new(@viewer, @view_context, User, PeoplePresenter).reveal
        end
        def top_motivations_html
          '<section>Top motivations</section>' # TODO: add top motivations list
        end
        def top_skills_html
          '<section>Top skills</section>' # TODO: add top skills list
        end
    end

end
