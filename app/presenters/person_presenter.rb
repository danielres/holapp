class PersonPresenter < Erector::Widget

  needs :viewer, :person, :view_context

  include Support::PresenterHelpers

  def content
    row do
      col(12) do
        page_head_html
        panel{ person_details_html }
        panel{ memberships_html }
        panel{ skills_html }
        panel{ motivations_html }
        panel{ dangerous_actions_menu_html }
      end
    end
  end


  private

    def page_head_html
      row do
        col(1){ text @view_context.image_tag(@person.image_url, width: 192) } if @person.image_url.present?
        col(11) do
          h1 do
            text @person.name
            small " (#{ @person.first_name } #{ @person.last_name })"
          end
        end
      end
    end

    def person_details_html
      row do
        col(4){ person_details1_html }
        col(8){ person_details2_html }
      end
    end

    def memberships_html
      text MembershipsPresenter.new(
                viewer: @viewer,
         source_object: @person,
          caption_text: 'Member of projects',
          view_context: @view_context,
          ).to_html
      text AddingAMembershipFromPerson
            .new(@viewer, Membership.new(person: @person))
            .view_context(@view_context)
            .get_user_input
    end

    def skills_html
      text ViewingATaggableTaggings.new(@viewer, @person, :skills).view_context(@view_context).call
      text AddingTaggings
            .new(@viewer, @person, nil, :skills)
            .view_context(@view_context)
            .get_user_input
    end

    def motivations_html
      text ViewingATaggableTaggings.new(@viewer, @person, :motivations).view_context(@view_context).call
      text AddingTaggings
            .new(@viewer, @person, nil, :motivations)
            .view_context(@view_context)
            .get_user_input
    end

    def person_details1_html
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
            best_in_place_activator(random_val, :cv_url)
            text best_in_place @person, :cv_url,
                    path: "/people/#{@person.to_param}",
                     nil: '…',
            display_with: ->(cv_url){ link_to cv_url, cv_url },
               activator: "##{ random_val }"
          end
        end
      end
    end

    def person_details2_html
      table.details do
        tr do
          th 'Description'
          td do
            random_val = (rand * 1000).to_i
            best_in_place_activator(random_val, :description)
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

    def dangerous_actions_menu_html
      h3 'Dangerous actions'
      actions_menu do
        ul do
          li delete_resource_link("/people/#{@person.to_param}")
        end
      end
    end

end
