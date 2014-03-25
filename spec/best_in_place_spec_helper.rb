module BestInPlace
  module TestHelpers
    module Custom
      def edit_in_place_text *args
        bip_text *args
        sleep 0.1
      end
      def edit_in_place_textarea *args
        bip_area *args
        sleep 0.1
      end
      def edit_in_place_select *args
        bip_select *args
        sleep 0.1
      end
    end
  end
end

RSpec.configure do |config|
  config.include BestInPlace::TestHelpers
  config.include BestInPlace::TestHelpers::Custom
end
