module LMP
  module Statistics
    class SR50OnTurns < Base
      def initialize
        @sr50_on_turns = false
      end

      def analyze_frame(frame)
        @sr50_on_turns = true if frame.sr50? && frame.turn != 0 && !frame.turn180?
      end

      def print
        puts "SR50 On Turns:   #{@sr50_on_turns}"
      end
    end
  end
end
