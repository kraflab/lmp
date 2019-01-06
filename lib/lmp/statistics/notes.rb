module LMP
  module Statistics
    class Notes
      def initialize
        @stroller = true
        @sr50_on_turns = false
        @turbo = false
      end

      def analyze_frame(frame)
        @turbo = true if frame.run.abs > 50 || frame.strafe.abs > 50
        @stroller = false if frame.strafe != 0 || frame.run.abs > 25
        @sr50_on_turns = true if frame.sr50? && frame.turn != 0
      end

      def print
        puts <<~EOF

          Turbo:         #{@turbo}
          Stroller:      #{@stroller}
          SR50 On Turns: #{@sr50_on_turns}
        EOF
      end
    end
  end
end
