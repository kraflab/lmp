module LMP
  module Statistics
    class Saves < Base
      def initialize
        @saves = 0
      end

      def analyze_frame(frame)
        @saves += 1 if frame.save
      end

      def print
        puts "Saves:          #{none_or_value(@saves)}"
      end
    end
  end
end
