module LMP
  module Vanilla
    class Frame
      attr_reader :run, :strafe, :turn, :events

      def initialize(file)
        @run = get_signed_byte(file)
        return if end_of_frames?
        @strafe = get_signed_byte(file)
        @turn = get_signed_byte(file)
        @events = file.getbyte
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
    end
  end
end
