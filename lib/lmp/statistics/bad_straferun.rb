module LMP
  module Statistics
    class BadStraferun < Base
      STAT_NAME = 'Bad Straferun'
      BAD_STRAFERUN_RANGE = 3

      def initialize
        @bad_straferun = {}
        @cost = 0.0
      end

      def analyze_frame(frame)
        if bad_straferun?(frame) && sr50_nearby?(frame)
          capture_instance(frame)
          @bad_straferun[frame.strafe.abs] ||= 0
          @bad_straferun[frame.strafe.abs] += 1
          @cost += cost(frame.strafe.abs)
        end
      end

      def print
        puts 'Bad Straferun:'
        if @bad_straferun.size == 0
          puts '  None'
          return
        end

        @bad_straferun.sort.each do |k, v|
          puts "  #{k}: #{v}"
        end
        puts ''
        puts "Total cost: #{@cost.round(2)}"
      end

      private

      def bad_straferun?(frame)
        frame.run.abs == 50 && frame.strafe != 0 && !frame.sr40? && !frame.sr50?
      end

      def sr50_nearby?(frame)
        frame.frame_window(BAD_STRAFERUN_RANGE).any? { |f| f.sr50? }
      end

      def cost(strafe)
        max_input = 70.71 # sr50
        input = Math.sqrt((50 * 50 + strafe * strafe).to_f)
        1 - input / max_input
      end
    end
  end
end
