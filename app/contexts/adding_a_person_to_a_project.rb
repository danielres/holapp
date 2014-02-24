class ActionForbiddenError < StandardError; end

class AddingAPersonToAProject

  def initialize(adder, person, project, view_context)
    @adder = adder if adder
    @person = person
    @project = project
    @view_context = view_context
    @adder.extend Adder
    @project.extend HasMembers if @project
    @person.extend IsMemberOfProject
  end

  def add
    @adder.add_person_to_project( @person, @project,
                       failure: ->(membership){ @controller.try(:failure, membership) },
                       success: ->(membership){ @controller.try(:success, membership) }, )
  end

  def expose_form
    return unless @adder.can_manage_memberships?
    h.render(partial: 'contexts/adding_a_person_to_a_project/form_from_person', locals: { person: @person })
  end

  def command(controller)
    @controller = controller
  end

  private

    def h
      @view_context
    end

    module Adder
      def add_person_to_project(person, project, callbacks = {})
        raise ActionForbiddenError unless can_manage_memberships?
        membership = Membership.new(project: project, user: person)
        membership.save ? callbacks[:success].call(membership) : callbacks[:failure].call(membership)
      end
      def can_manage_memberships?
        Ability.new(self).can? :manage, :memberships
      end
    end

    module HasMembers
      def self.extended(object)
        object.class.class_eval do
          has_many :memberships
          has_many :members, through: :memberships, source: :user
        end
      end
    end

    module IsMemberOfProject
      def self.extended(object)
        object.class.class_eval do
          # has_many :memberships
          # has_many :project, through: :memberships
        end
      end
    end

end
