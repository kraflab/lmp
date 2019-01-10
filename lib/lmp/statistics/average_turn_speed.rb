module LMP
  module Statistics
    class AverageTurnSpeed
      def initialize
        @total_turn = 0
        @turns = []
        @turn_count = 0
      end

      def analyze_frame(frame)
        add_turn(frame.turn) if frame.turning?
      end

      def print
        puts "Average Turn Speed: #{average_turn_speed}"
        puts "Standard Deviation: #{standard_deviation}"
      end

      private

      def add_turn(turn)
        @total_turn += turn.abs
        @turns << turn
        @turn_count += 1
      end

      def average_turn_speed
        @average_turn_speed = (@total_turn.to_f / @turn_count).round(2)
      end

      def standard_deviation
        Math.sqrt(variance).round(2)
      end

      def variance
        @turns
          .map { |turn| (turn - average_turn_speed) ** 2 }
          .reduce(0, :+) / (@turn_count - 1)
      end
    end
  end
end
