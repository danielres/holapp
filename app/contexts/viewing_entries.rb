class ViewingEntries

  def initialize(user, type_to_show, presenter)
    @spectator = user
    @spectator.extend Spectator
    @type_to_show = type_to_show
    @presenter = presenter
  end

  def reveal
    render( @spectator.available_objects_of_type(@type_to_show), @presenter )
  end

  private

    module Spectator
      def available_objects_of_type type
        type.accessible_by(Ability.new(self), :read)
      end
    end

    def render(objects, presenter)
      presenter.new(objects).as_html
    end


end
