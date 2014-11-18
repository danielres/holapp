module News


  class Fetcher

    def initialize(user, filter)
      @user   = user
      @filter = filter
    end


    def call
      case @filter
      when 'interesting' then interesting
      else all
      end
    end


    private

      def interesting
        Item.all.select{ |i| interesting?(i) }
      end

      def all
        Item.all
      end

      def interesting?(news_item)
        ( @user.taggings.map(&:tag) & news_item.taggings.map(&:tag) ).any?
      end


  end
end
