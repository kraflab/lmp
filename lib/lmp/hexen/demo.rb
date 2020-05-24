require_relative 'frame'
require_relative 'details_presenter'

module LMP
  module Hexen
    class Demo < Heretic::Demo
      attr_reader :player_1_class, :player_2_class,
                  :player_3_class, :player_4_class,
                  :player_5, :player_5_class, :player_6, :player_6_class,
                  :player_7, :player_7_class, :player_8, :player_8_class

      def details
        DetailsPresenter.call(self)
      end

      private

      def parse_players(file)
        @player_1 = file.getbyte
        @player_1_class = file.getbyte

        # vvHeretic special flags hidden in player_1 byte
        @respawn    = @player_1 & 0x20 != 0
        @longtics   = @player_1 & 0x10 != 0
        @nomonsters = @player_1 & 0x02 != 0

        @player_2 = file.getbyte
        @player_2_class = file.getbyte
        @player_3 = file.getbyte
        @player_3_class = file.getbyte
        @player_4 = file.getbyte
        @player_4_class = file.getbyte
        @player_5 = file.getbyte
        @player_5_class = file.getbyte
        @player_6 = file.getbyte
        @player_6_class = file.getbyte
        @player_7 = file.getbyte
        @player_7_class = file.getbyte
        @player_8 = file.getbyte
        @player_8_class = file.getbyte
      end

      def parse_frames(file)
        @frames = []

        loop do
          frame = Frame.new(file, @longtics, @frames.last, @frames.count)
          break if frame.end_of_frames? || file.eof?
          @frames << frame
        end
      end
    end
  end
end
