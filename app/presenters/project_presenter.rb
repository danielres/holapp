class ProjectPresenter < Erector::Widget

  needs :viewer, :project, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do

      h1 @project.name

      panel do
        table.details do
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
        text memberships_table
        text AddingAMembership.new(@viewer, nil, @project).gather_user_input(@view_context)
      end

      panel do
        text ViewingATaggableTaggings.new(@viewer, @project).expose_list(:skills, @view_context)
        text AddingTaggings.new(@viewer, @project, nil, :skills).gather_user_input(@view_context)
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

  private

    def memberships_table
      table the('memberships-list') do
        caption 'Members'
        @project.memberships.each do |m|
          tr do
            td.name link_to m.user.name, m.user
            td.description best_in_place m, :description, type: :textarea, nil: '…'
          end
        end
      end
    end


end
