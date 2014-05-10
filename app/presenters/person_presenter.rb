class PersonPresenter < Erector::Widget

  needs :viewer, :person, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do
      menu do
        ul the('actions-menu') do
          li delete_resource_link("/people/#{@person.to_param}")
        end
      end
      h1 do
        text @person.name
        small " (#{ @person.first_name } #{ @person.last_name })"
      end
      p @person.email
      panel do
        row do
          col(4){ details_table1 }
          col(8){ details_table2 }
        end
      end

      panel do
        memberships
        text AddingAMembership.new(@viewer, @person, nil).gather_user_input(@view_context)
      end

      panel do
        text ViewingATaggableTaggings.new(@viewer, @person).expose_list(:skills, @view_context)
        text AddingTaggings.new(@viewer, @person, nil, :skills).gather_user_input(@view_context)
      end

      panel do
        text ViewingATaggableTaggings.new(@viewer, @person).expose_list(:motivations, @view_context)
        text AddingTaggings.new(@viewer, @person, nil, :motivations).gather_user_input(@view_context)
      end

    end
  end


  private

    def details_table1
      table.details do
        tr do
          th 'Firstname'
          td best_in_place @person, :first_name,  path: "/people/#{@person.to_param}", nil: '…'
        end
        tr do
          th 'Last name'
          td best_in_place @person, :last_name,  path: "/people/#{@person.to_param}", nil: '…'
        end
        tr do
          th 'Display name'
          td best_in_place @person, :display_name,  path: "/people/#{@person.to_param}", nil: '…'
        end
        tr do
          th 'Trigram'
          td best_in_place @person, :trigram,  path: "/people/#{@person.to_param}", nil: '…'
        end
      end
    end

    def details_table2
      table.details do
        tr do
          th 'Description'
          td best_in_place @person, :description, type: :textarea, path: "/people/#{@person.to_param}", nil: '…'
        end
      end
    end

    def memberships
      table the('memberships-list') do
        caption 'Member of projects'
        @person.memberships.each do |m|
          tr do
            td.name         link_to(m.project.name, m.project)
            td.description  best_in_place(m, :description, type: :textarea, nil: '…')
            td.actions do
              ul do
                li delete_resource_link(m)
              end
            end
          end
        end
      end
    end

end
