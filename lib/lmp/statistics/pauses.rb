module LMP
  module Statistics
    class Pauses < Base
      def initialize
        @pauses = 0
      end

      def analyze_frame(frame)
        @pauses += 1 if frame.pause
      end

      def print
        puts "Pauses:          #{none_or_value(@pauses)}"
      end
    end
  end
end
