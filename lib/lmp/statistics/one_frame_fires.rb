module LMP
  module Statistics
    class OneFrameFires < Base
      def initialize
        @one_frame_fires = 0
        @fire_count = 0
        @fire_history = []
      end

      def analyze_frame(frame)
        @fire_count += 1 if frame.fire
        @fire_history << frame.fire

        return if @fire_history.length < 3

        @one_frame_fires += 1 if one_frame_fire?(frame)
        @fire_history.shift
      end

      def print
        puts "One Frame Fires: #{none_or_value(@one_frame_fires)} / #{@fire_count}"
      end

      private

      def one_frame_fire?(frame)
        !@fire_history[0] && @fire_history[1] && !frame.fire
      end
    end
  end
end
