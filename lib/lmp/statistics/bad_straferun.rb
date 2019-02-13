module LMP
  module Statistics
    class BadStraferun < Base
      def initialize
        @bad_straferun = {}
        @cost = 0.0
      end

      def analyze_frame(frame)
        if frame.run.abs == 50 && frame.strafe != 0 && !frame.sr40? && !frame.sr50?
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

      def cost(strafe)
        max_input = 70.71 # sr50
        input = Math.sqrt((50 * 50 + strafe * strafe).to_f)
        1 - input / max_input
      end
    end
  end
end
