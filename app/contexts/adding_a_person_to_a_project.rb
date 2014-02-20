class AddingAPersonToAProject

  def initialize(adder, person, project)
    @adder = adder
    @person = person
    @project = project
    @adder.extend Adder
    @project.extend HasMembers
    @person.extend IsMemberOfProject
  end

  def add
    if @adder.can_manage_memberships?
      @project.members << @person
    end
  end

  private

    module Adder
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
          has_many :memberships
          has_many :project, through: :memberships
        end
      end
    end

end
