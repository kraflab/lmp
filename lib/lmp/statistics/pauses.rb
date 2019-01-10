module LMP
  module Statistics
    class Pauses
      def initialize
        @pauses = 0
      end

      def analyze_frame(frame)
        @pauses += 1 if frame.pause
      end

      def print
        puts "Pauses:         #{pauses_string}"
      end

      private

      def pauses_string
        @pauses == 0 ? 'None' : @pauses
      end
    end
  end
end
