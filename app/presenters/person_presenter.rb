class PersonPresenter < Erector::Widget

  needs :viewer, :person, :view_context

  include Support::PresenterHelpers

  def content

    col(12) do
      row do
        col(1){ text @view_context.image_tag(@person.image_url, width: 192) } if @person.image_url.present?
        col(11) do
          h1 do
            text @person.name
            small " (#{ @person.first_name } #{ @person.last_name })"
          end
        end
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

      panel do
        h3 'Dangerous actions'
        actions_menu do
          ul do
            li delete_resource_link("/people/#{@person.to_param}")
          end
        end
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
            random_val = (rand * 1000).to_i
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
          td do
            random_val = (rand * 1000).to_i
            params = { id: "#{ random_val }", style: 'float: right' }.merge the('description_edit_action')
            small(params){ a 'edit' }
            text best_in_place @person, :description,
                    type: :textarea,
                    path: "/people/#{@person.to_param}",
                     nil: '…',
            display_with: ->(txt){ render_description(txt) },
               activator: "##{ random_val }"
          end

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
            td.durations do
              membership_durations(m)
              text AddingADuration.new(@viewer, m).gather_user_input(@view_context)
            end
            td.actions do
              ul do
                li delete_resource_link(m)
              end
            end
          end
        end
      end
    end

    def membership_durations(membership)
      durations = Duration.where(durable_id: membership.id, durable_type: 'Membership')
      div( 'data-purpose' => 'durations-list' ) do
        durations.each do |d|
          div.duration do
            small 'from'
            text best_in_place d, :starts_at, type: :date, display_with: ->(d){ pretty_date(d) }
            small 'to'
            text best_in_place d, :ends_at  , type: :date, display_with: ->(d){ pretty_date(d) }
            hr
          end
        end
      end
    end

end
