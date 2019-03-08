module LMP
  module Statistics
    class OneFrameUses < Base
      STAT_NAME = 'One Frame Uses'

      def initialize
        @one_frame_uses = 0
        @use_count = 0
      end

      def analyze_frame(frame)
        one_frame_use!(frame) if one_frame_use?(frame)
        @use_count += 1 if frame.prev_frame.use && !frame.use
      end

      def print
        puts "One Frame Uses:  #{none_or_value(@one_frame_uses)} / #{@use_count}"
      end

      private

      def one_frame_use?(frame)
        !frame.prev_frame.use && frame.use && !frame.next_frame.use
      end

      def one_frame_use!(frame)
        @one_frame_uses += 1
        capture_instance(frame)
      end
    end
  end
end
