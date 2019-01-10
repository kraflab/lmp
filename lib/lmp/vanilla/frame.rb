module LMP
  module Vanilla
    class Frame
      attr_reader :run, :strafe, :turn,
                  :event_bits, :pause, :save, :fire, :use, :weapon

      def initialize(file)
        @run = get_signed_byte(file)
        return if end_of_frames?
        @strafe = get_signed_byte(file)
        @turn = get_signed_byte(file)
        @pause = false
        @save = false
        @fire = false
        @use = false
        @weapon = false
        parse_events(file)
      end

      def end_of_frames?
        run == -128
      end

      def moving?
        run != 0 || strafe != 0
      end

      def sr40?
        run.abs == 50 && strafe.abs == 40
      end

      def sr45?
        run.abs == 50 && strafe.abs > 40 && strafe.abs < 50
      end

      def sr50?
        run.abs == 50 && strafe.abs == 50
      end

      def turning?
        turn != 0
      end

      private

      def get_signed_byte(file)
        [file.getbyte].pack('c').unpack('c')[0]
      end

      def parse_events(file)
        events = file.getbyte
        @event_bits = events.to_s(2).reverse.chars.map(&:to_i)
        event_bits[7] ? parse_special : parse_nonspecial
      end

      def parse_special
        @pause = event_bits[0] == 1
        @save = event_value_at(2, 4) + 1 if event_bits[1] == 1
      end

      def parse_nonspecial
        @fire = event_bits[0] == 1
        @use = event_bits[1] == 1
        @weapon = event_value_at(3, 5) + 1 if event_bits[2] == 1
      end

      def event_value_at(a, b)
        event_bits[a..b].map(&:to_s).join.reverse.to_i(2)
      end
    end
  end
end
