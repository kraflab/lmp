module LMP
  module Analysis
    class RouteTrace < Base
      ANALYSIS_NAME = 'route_trace'

      def initialize()
        @path = []
        @path << Position.initial
        @angle = 0
      end

      def analyze_frame(frame)
        @angle += frame.turn
        @angle %= 256

        radians = Math::PI * @angle.to_f / 128
        cos = Math.cos(radians)
        sin = Math.sin(radians)

        delta_x =  frame.strafe * sin + frame.run * cos
        delta_y = -frame.strafe * cos + frame.run * sin

        @path << Position.new(delta_x, delta_y, from: @path[-1])
      end

      def report_to(file)
        @path.each { |i| file.puts i.to_s }
      end

      class Position
        attr_reader :x, :y

        def initialize(x, y, from: nil)
          @x = (from ? from.x : 0) + x
          @y = (from ? from.y : 0) + y

          freeze
        end

        def self.initial
          new(0, 0)
        end

        def to_s
          "#{x} #{y}"
        end
      end
    end
  end
end
