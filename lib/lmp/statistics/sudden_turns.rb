module LMP
  module Statistics
    class SuddenTurns
      IGNORE_LIMIT = 4
      IGNORE_FRAMES = 2

      def initialize
        @sudden_turns = {}
        @last_turn = nil
        @ignore_frames = IGNORE_FRAMES
      end

      def analyze_frame(frame)
        if @ignore_frames > 0
          @ignore_frames -= 1
          @last_turn = frame.turn
          return
        end

        if @last_turn == 0 && frame.turn.abs > IGNORE_LIMIT
          sudden_turn!(frame.turn)
        end

        if @last_turn.abs > IGNORE_LIMIT && frame.turn == 0
          sudden_turn!(@last_turn)
        end

        @last_turn = frame.turn
      end

      def print
        puts ''
        puts 'Sudden Turns:'
        puts '  None' unless @sudden_turns.size > 0
        @sudden_turns.sort.each do |k, v|
          puts "  #{k} (#{v})"
        end
      end

      private

      def sudden_turn!(turn)
        @sudden_turns[turn.abs] ||= 0
        @sudden_turns[turn.abs] += 1
      end
    end
  end
end
