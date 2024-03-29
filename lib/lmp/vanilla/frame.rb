require_relative 'frame_presenter'

module LMP
  module Vanilla
    class Frame
      attr_reader :run, :strafe, :turn, :index, :join,
                  :events, :event_bits, :pause, :save, :fire, :use, :weapon
      attr_writer :next_frame

      def initialize(file, longtics, prev_frame, index)
        @run = get_signed_byte(file)
        return if end_of_frames?
        @strafe = get_signed_byte(file)
        @turn = read_turn(file, longtics)
        parse_events(file)
        connect_frame(prev_frame)
        @index = index
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

      def turn180?
        turn == -128
      end

      def next_frame
        @next_frame || NilFrame.new
      end

      def prev_frame
        @prev_frame || NilFrame.new
      end

      def frame_window(n)
        prev_frames = [self]
        n.times { prev_frames << prev_frames[-1].prev_frame }

        next_frames = [self]
        n.times { next_frames << next_frames[-1].next_frame }

        prev_frames.reverse | next_frames
      end

      def to_s(options = {})
        FramePresenter.call(self, options)
      end

      def to_i
        ((run & 255) << 24) \
        + ((strafe & 255) << 16) \
        + ((turn & 255) << 8) \
        + events
      end

      private

      def connect_frame(frame)
        return if frame.nil?

        @prev_frame = frame
        frame.next_frame = self
      end

      def get_signed_byte(file)
        [file.getbyte].pack('c').unpack('c')[0]
      end

      def read_turn(file, longtics)
        file.getbyte if longtics
        get_signed_byte(file)
      end

      def parse_events(file)
        @pause = false
        @save = false
        @fire = false
        @use = false
        @weapon = false
        @events = file.getbyte
        @event_bits = events.to_s(2).reverse.chars.map(&:to_i)
        event_bits[7] ? parse_special : parse_nonspecial
        @join = (event_bits[6] == 1 && !weapon)
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

      class NilFrame < Frame
        def initialize
          @run = 0
          @strafe = 0
          @turn = 0
          @pause = false
          @save = false
          @fire = false
          @use = false
          @weapon = false
          @events = 0
          @join = false
        end
      end
    end
  end
end
