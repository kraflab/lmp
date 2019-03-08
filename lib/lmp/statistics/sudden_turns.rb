module LMP
  module Statistics
    class SuddenTurns < Base
      STAT_NAME = 'Sudden Turns'
      VERBOSE_STAT_WINDOW = 2
      IGNORE_LIMIT = 9
      IGNORE_FRAMES = 3

      def initialize
        @sudden_turns = {}
      end

      def analyze_frame(frame)
        return if frame.index < IGNORE_FRAMES

        sudden_turn_start!(frame) if sudden_turn_start?(frame)
        sudden_turn_end!(frame) if sudden_turn_end?(frame)
      end

      def print
        puts 'Sudden Turns:'
        puts '  None' unless @sudden_turns.size > 0
        @sudden_turns.sort.each do |k, v|
          puts "  #{k} (start: #{v[:start]}, end: #{v[:end]})"
        end
      end

      private

      def sudden_turn_start?(frame)
        frame.prev_frame.turn == 0 &&
          frame.turn.abs > IGNORE_LIMIT &&
          frame.next_frame.turn != 0
      end

      def sudden_turn_start!(frame)
        @sudden_turns[frame.turn.abs] ||= { start: 0, end: 0 }
        @sudden_turns[frame.turn.abs][:start] += 1
        capture_instance(frame)
      end

      def sudden_turn_end?(frame)
        frame.prev_frame.turn != 0 &&
          frame.turn.abs > IGNORE_LIMIT &&
          frame.next_frame.turn == 0
      end

      def sudden_turn_end!(frame)
        @sudden_turns[frame.turn.abs] ||= { start: 0, end: 0 }
        @sudden_turns[frame.turn.abs][:end] += 1
        capture_instance(frame)
      end
    end
  end
end
