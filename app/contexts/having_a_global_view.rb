class HavingAGlobalView
  def initialize(user)
    @viewer = user
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
        ].join
      end
      private
        def projects_html
          ViewingProjects.new(@viewer).view
        end
        def people_html
          '<section>People</section>' # TODO: add people list
        end
        def top_motivations_html
          '<section>Top motivations</section>' # TODO: add top motivations list
        end
        def top_skills_html
          '<section>Top skills</section>' # TODO: add top skills list
        end
    end

end
