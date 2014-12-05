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
        news_item_themes     = news_item.taggings.select{|t| t.context == 'themes' }.map(&:tag)
        user_motivations     = @user.taggings.select{|t| t.context == 'motivations'}.map(&:tag)
        user_motivations_sub = user_motivations.map(&:children).flatten
        user_motivations_sub += user_motivations_sub.map(&:children).flatten
        all_user_motivations = user_motivations + user_motivations_sub
        (  all_user_motivations & news_item_themes ).any?
      end


  end
end
