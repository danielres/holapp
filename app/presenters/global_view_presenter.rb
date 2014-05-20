class GlobalViewPresenter < Erector::Widget

  needs :viewer, :view_context

  include Support::PresenterHelpers

  def content
    row do
      col(6) do
        panel do
          text ViewingPeople.new(@viewer).expose_list(@view_context)
          text AddingAPerson.new(@viewer).gather_user_input(@view_context)
        end
      end
      col(6) do
        panel do
          text ViewingProjects.new(@viewer).expose_list(@view_context)
          text AddingAProject.new(@viewer).gather_user_input(@view_context)
        end
      end
    end

    row do
      col(6) do
        panel do
          text TopsByTagFieldPresenter.new(tag_field: :motivations, min_level: 3, view_context: @view_context).to_html
        end
      end
      col(6) do
        panel do
          text TopsByTagFieldPresenter.new(tag_field: :skills,      min_level: 3, view_context: @view_context).to_html
        end
      end
    end


  end

end
