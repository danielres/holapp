class ProjectPresenter < Erector::Widget

  needs :viewer, :project, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do

      h1 @project.name

      panel do
        table.details do
          tr do
            th 'Name'
            td best_in_place @project, :name
          end
          tr do
            th 'Description'
            td do
              random_val = (rand * 1000).to_i
              best_in_place_activator(random_val, :description)
              text best_in_place @project, :description,
                      type: :textarea,
                       nil: '…',
              display_with: ->(txt){ render_description(txt) },
                 activator: "##{ random_val }"
            end
          end
          tr do
            th 'Start'
            td best_in_place @project, :starts_at, type: :date, display_with: ->(d){ pretty_date(d) }
          end
          tr do
            th 'End'
            td best_in_place @project, :ends_at, type: :date, display_with: ->(d){ pretty_date(d) }
          end
        end
      end

      panel do
        text MembershipsPresenter.new(
                    viewer: @viewer,
             source_object: @project,
              caption_text: 'Members',
              view_context: @view_context,
            ).to_html
        text AddingAMembershipFromProject
              .new(@viewer, Membership.new(project: @project))
              .view_context(@view_context)
              .get_user_input
      end

      panel do
        text ViewingATaggableTaggings.new(@viewer, @project, :skills).view_context(@view_context).call
        text AddingTaggings
              .new(@viewer, @project, nil, :skills)
              .view_context(@view_context)
              .get_user_input
      end

      panel do
        h3 'Dangerous actions'
        actions_menu do
          ul do
            li delete_resource_link("/projects/#{@project.to_param}")
          end
        end
      end


    end

  end



end
