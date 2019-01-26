module LMP
  module Statistics
    class OneFrameUses < Base
      def initialize
        @one_frame_uses = 0
        @use_count = 0
        refresh
      end

      def refresh
        @use_history = []
      end

      def analyze_frame(frame)
        @use_history << frame.use

        return if @use_history.length < 3

        @one_frame_uses += 1 if one_frame_use?(frame)
        @use_count += 1 if @use_history[1] && !frame.use
        @use_history.shift
      end

      def print
        puts "One Frame Uses:  #{none_or_value(@one_frame_uses)} / #{@use_count}"
      end

      private

      def one_frame_use?(frame)
        !@use_history[0] && @use_history[1] && !frame.use
      end
    end
  end
end
