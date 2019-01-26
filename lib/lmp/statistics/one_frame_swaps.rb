module LMP
  module Statistics
    class OneFrameSwaps < Base
      def initialize
        @one_frame_swaps = 0
        @swap_count = 0
        refresh
      end

      def refresh
        @swap_history = []
      end

      def analyze_frame(frame)
        @swap_count += 1 if frame.weapon
        @swap_history << frame.weapon

        return if @swap_history.length < 3

        @one_frame_swaps += 1 if one_frame_swap?(frame)
        @swap_history.shift
      end

      def print
        puts "One Frame Swaps: #{none_or_value(@one_frame_swaps)} / #{@swap_count}"
      end

      private

      def one_frame_swap?(frame)
        !@swap_history[0] && @swap_history[1] && !frame.weapon
      end
    end
  end
end
