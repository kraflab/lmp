module LMP
  module Statistics
    class Turbo
      def initialize
        @turbo = false
      end

      def analyze_frame(frame)
        @turbo = true if frame.run.abs > 50 || frame.strafe.abs > 50
      end

      def print
        puts "Turbo:         #{@turbo}"
      end
    end
  end
end
