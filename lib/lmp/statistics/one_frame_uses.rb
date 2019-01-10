module LMP
  module Statistics
    class OneFrameUses
      def initialize
        @one_frame_uses = 0
        @use_history = []
      end

      def analyze_frame(frame)
        @use_history << frame.use

        return if @use_history.length < 3

        @one_frame_uses += 1 if one_frame_use?(frame)
        @use_history.shift
      end

      def print
        puts "One Frame Uses: #{one_frame_uses_string}"
      end

      private

      def one_frame_use?(frame)
        !@use_history[0] && @use_history[1] && !frame.use
      end

      def one_frame_uses_string
        @one_frame_uses == 0 ? 'None' : @one_frame_uses
      end
    end
  end
end
