module LMP
  module Statistics
    class TurnFrequency < Base
      def initialize
        @turning_count = 0
        @turning_histogram = {}
      end

      def analyze_frame(frame)
        @turning_count += 1 if frame.turning?
        @turning_histogram[frame.turn.abs] ||= 0
        @turning_histogram[frame.turn.abs] += 1
      end

      def print
        return inapplicable_print if @turning_count == 0

        puts 'Turn Frequency:'
        @turning_histogram.delete(0)
        @turning_histogram.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / @turning_count).round(4)}"
        end
      end

      private

      def inapplicable_print
        puts "No turn detected!"
      end
    end
  end
end
