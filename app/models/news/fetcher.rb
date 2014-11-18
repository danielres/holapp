module News


  class Fetcher

    def initialize(user, filter, created_after = nil)
      @user   = user
      @filter = filter
      @created_after = created_after || DateTime.new(2000)
    end


    def call
      case @filter
      when 'interesting' then interesting
      else all
      end
    end


    private

      def interesting
        all.select{ |i| interesting?(i) }
      end

      def all
        Item.where("created_at > :created_after", { created_after: @created_after } )
      end

      def interesting?(news_item)
        ( @user.taggings.map(&:tag) & news_item.taggings.map(&:tag) ).any?
      end


  end
end
