module Support
  module PresenterHelpers
    def domain_language text
      text == 'User' ? 'Person' : text
    end
    def the(purpose_name)
      {'data-purpose' => purpose_name }
    end
    def col(width)
      div(class: "col-md-#{width}"){ yield }
    end
    def panel
      div(class: "panel"){ yield }
    end
    def row
      div(class: "row"){ yield }
    end
    def menu
      rawtext "<menu>"
      yield
      rawtext "</menu>"
    end
    def delete_resource_link(resource)
      confirm_message = Rails.env == 'test' ? false : 'Are you sure ?'
      @view_context.link_to('delete', resource, method: :delete, data: { purpose: 'delete-action', confirm: confirm_message })
    end
    def best_in_place *args
      @view_context.best_in_place *args
    end

  end
end
