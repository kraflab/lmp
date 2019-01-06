module LMP
  module Statistics
    class StraferunFrequency
      def initialize
        @sr40_count = 0
        @sr50_count = 0
        @sr45_count = 0
        @moving_count = 0
        @run_histogram = {}
        @strafe_histogram = {}
      end

      def analyze_frame(frame)
        @moving_count += 1 if frame.moving?
        @sr40_count += 1 if frame.sr40?
        @sr50_count += 1 if frame.sr50?
        @sr45_count += 1 if frame.sr45?
        @run_histogram[frame.run.abs] ||= 0
        @run_histogram[frame.run.abs] += 1
        @strafe_histogram[frame.strafe.abs] ||= 0
        @strafe_histogram[frame.strafe.abs] += 1
      end

      def print
        puts ''
        puts "SR40: #{(100 * @sr40_count / @moving_count).to_s.rjust(3)} %"
        puts "SR50: #{(100 * @sr50_count / @moving_count).to_s.rjust(3)} %"
        puts "SR45: #{(100 * @sr45_count / @moving_count).to_s.rjust(3)} %" if (100 * @sr45_count / @moving_count) > 0
        puts "SR:   #{(100 * (@sr40_count + @sr50_count + @sr45_count) / @moving_count).to_s.rjust(3)} %"

        puts ''
        puts 'Run Frequency:'
        @run_histogram.delete(0)
        @run_histogram.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / @moving_count).round(4)}"
        end

        puts ''
        puts 'Strafe Frequency:'
        @strafe_histogram.delete(0)
        @strafe_histogram.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / @moving_count).round(4)}"
        end
      end
    end
  end
end
