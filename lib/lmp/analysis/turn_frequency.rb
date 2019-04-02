module LMP
  module Analysis
    class TurnFrequency < Base
      ANALYSIS_NAME = 'turn_frequency'

      def initialize
        @count = {}
      end

      def analyze_frame(frame)
        @count[frame.turn] ||= 0
        @count[frame.turn] += 1
      end

      def report_to(file)
        positive = @count.select { |turn, _| turn > 0 }
        negative = @count.select { |turn, _| turn < 0 }

        dump_sub_set(file, positive)
        file.puts "\n\n"
        dump_sub_set(file, negative)
      end

      private

      def dump_sub_set(file, set)
        total = set.sum { |_, count| count }
        set.sort.each do |turn, count|
          file.puts "#{turn} #{count.to_f / total}"
        end
      end
    end
  end
end
