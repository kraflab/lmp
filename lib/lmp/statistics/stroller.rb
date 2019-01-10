module LMP
  module Statistics
    class Stroller
      def initialize
        @stroller = true
      end

      def analyze_frame(frame)
        @stroller = false if frame.strafe != 0 || frame.run.abs > 25
      end

      def print
        puts "Stroller:       #{@stroller}"
      end
    end
  end
end
