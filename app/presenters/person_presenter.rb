class PersonPresenter < Erector::Widget

  needs :viewer, :person, :view_context

  include Support::PresenterHelpers

  def content
    col(12) do
      actions_menu do
        ul do
          li delete_resource_link("/people/#{@person.to_param}")
        end
      end
      h1 do
        text @person.name
        small " (#{ @person.first_name } #{ @person.last_name })"
      end
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
          th 'Email'
          td do
            a @person.email, href: "mailto:#{@person.email}"
          end
        end
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
        tr do
          th 'Mobile'
          td best_in_place @person, :mobile,  path: "/people/#{@person.to_param}", nil: '…'
        end
        tr do
          th 'CV url'
          td do
            - random_val = (rand * 1000).to_i
            params = { id: "#{ random_val }", style: 'float: right' }.merge the('cv_url_edit_action')
            small(params){ a 'edit' }
            text best_in_place @person, :cv_url,  path: "/people/#{@person.to_param}", nil: '…', activator: "##{ random_val }", display_with: ->(cv_url){ link_to cv_url, cv_url }
          end
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
