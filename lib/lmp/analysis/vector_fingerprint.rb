module LMP
  module Analysis
    class VectorFingerprint < Base
      ANALYSIS_NAME = 'vector_fingerprint'

      def initialize
        @count = {}
      end

      def analyze_frame(frame)
        frame_value = frame.to_i
        return unless frame_value > 0

        @count[frame.to_i] ||= 0
        @count[frame.to_i] += 1
      end

      def report_to(file)
        @count.sort_by { |k, v| v }.each do |k, v|
          file.puts "#{k} #{v / magnitude}"
        end
      end

      private

      def magnitude
        @magnitude ||= Math.sqrt(@count.sum { |k, v| v * v })
      end
    end
  end
end
