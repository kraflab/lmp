module LMP
  module Analysis
    class TurnStartDistribution < Base
      ANALYSIS_NAME = 'turn_start_distribution'
      IGNORE_FRAMES = 2

      def initialize
        @count = 0
        @distribution = []
        256.times { @distribution << [0] * 256 }
      end

      def analyze_frame(frame)
        return if frame.index < IGNORE_FRAMES
        return unless start?(frame) && long_turn?(frame)

        @count += 1
        @distribution[frame.prev_frame.turn + 128][frame.turn + 128] += 1
      end

      def report_to(file)
        @distribution.each do |row|
          file.puts data(row)
        end
      end

      def data(row)
        row.map { |i| (i.to_f / @count).to_s }.join(' ')
      end

      private

      def start?(frame)
        frame.prev_frame.prev_frame.turn == 0 && frame.prev_frame.turn != 0
      end

      def long_turn?(frame)
        [
          frame,
          frame.next_frame,
          frame.next_frame.next_frame
        ].none? { |frame| frame.turn == 0 }
      end
    end
  end
end
