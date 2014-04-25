class AddingAPerson < AddingAResource

  private

    def context_name
      'adding_a_person'
    end

    def new_resource(attributes={})
      User.new(random_attributes.merge(attributes).symbolize_keys)
    end

    def random_attributes
      random_val = (rand * 10000).to_i
      { email: "ChangeMe#{ random_val }@changeme.com", password: "password" }
    end

end

