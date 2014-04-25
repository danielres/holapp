class AddingAMembership < AddingAResource

  def initialize(adder, person, project)
    @adder = adder if adder
    @person = person
    @project = project
    @adder.extend AddingAResource::Adder
  end

  def execute
    resource = new_resource(person: @person, project: @project)
    @adder.add_resource( resource,
                       create_failure: ->{ @controller.try(:create_failure, resource) },
                       create_success: ->{ @controller.try(:create_success, resource) }, )
  end


  private

    def context_name
      'adding_a_membership'
    end

    def new_resource(attributes={})
      Membership.new(attributes)
    end

    def render_form_attributes
      if @person
        { partial: 'contexts/adding_a_membership/form_from_person',  locals: { person: @person } }
      else
        { partial: 'contexts/adding_a_membership/form_from_project', locals: { project: @project } }
      end
    end


end
