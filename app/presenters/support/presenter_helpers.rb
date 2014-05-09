module Support
  module PresenterHelpers
    def domain_language text
      text == 'User' ? 'Person' : text
    end
    def the(purpose_name)
      {'data-purpose' => purpose_name }
    end
  end
end
