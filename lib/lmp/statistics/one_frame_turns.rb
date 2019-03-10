module LMP
  module Statistics
    class OneFrameTurns < Base
      STAT_NAME = 'One Frame Turns'
      IGNORE_LIMIT = 9
      IGNORE_FRAMES = 2

      def initialize
        @one_frame_turns = {}
      end

      def analyze_frame(frame)
        return if frame.index < IGNORE_FRAMES

        one_frame_turn!(frame) if one_frame_turn?(frame)
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
        frame.prev_frame.turn == 0 &&
          frame.turn.abs > IGNORE_LIMIT &&
          frame.next_frame.turn == 0
      end

      def one_frame_turn!(frame)
        @one_frame_turns[frame.turn.abs] ||= 0
        @one_frame_turns[frame.turn.abs] += 1
        capture_instance(frame)
      end
    end
  end
end
