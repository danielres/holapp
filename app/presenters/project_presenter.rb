class ProjectPresenter < Erector::Widget

  needs :viewer, :project, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do

      menu do
        ul the('actions-menu') do
          li delete_resource_link("/projects/#{@project.to_param}")
        end
      end

      h1 @project.name

      panel do
        table.details do
          tr do
            th 'Description'
            td best_in_place @project, :description, type: :textarea, nil: '…'
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
