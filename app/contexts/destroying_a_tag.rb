class DestroyingATag < DestroyingAResource

  def initialize(destroyer, resource)
    super
    @resource = resource
    @resource.extend DestructibleTag
  end

  private

    module DestructibleTag
      def self.extended(object)
        object.class.class_eval do
          has_many :taggings, dependent: :destroy
        end
      end
    end

end

