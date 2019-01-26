module LMP
  module Statistics
    class OneFrameTurns < Base
      IGNORE_LIMIT = 9

      def initialize
        @one_frame_turns = {}
        refresh
      end

      def refresh
        @turn_history = []
      end

      def analyze_frame(frame)
        @turn_history << frame.turn

        return if @turn_history.length < 3

        one_frame_turn!(@turn_history[1]) if one_frame_turn?(frame)

        @turn_history.shift
      end

      def print
        puts 'One Frame Turns:'
        puts '  None' unless @one_frame_turns.size > 0
        @one_frame_turns.sort.each do |k, v|
          puts "  #{k} (#{v})"
        end
      end

      private

      def one_frame_turn?(frame)
        @turn_history[0] == 0 &&
          @turn_history[1].abs > IGNORE_LIMIT &&
          frame.turn == 0
      end

      def one_frame_turn!(turn)
        @one_frame_turns[turn.abs] ||= 0
        @one_frame_turns[turn.abs] += 1
      end
    end
  end
end
