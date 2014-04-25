class AddingAProject < AddingAResource

  private

    def context_name
      'adding_a_project'
    end

    def new_resource(attributes={})
      Project.new(random_attributes.merge(attributes))
    end

    def random_attributes
      { name: "ChangeMe#{ random_val }" }
    end

end

