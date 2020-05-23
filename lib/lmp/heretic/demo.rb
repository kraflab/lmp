require_relative 'frame'
require_relative 'frames_presenter'
require_relative 'details_presenter'

module LMP
  module Heretic
    class Demo
      attr_reader :version, :skill, :episode, :level, :play_mode, :respawn,
                  :fast, :nomonsters, :point_of_view, :player_1, :player_2,
                  :player_3, :player_4, :frames, :filename, :longtics

      def initialize(filename)
        file = File.open(filename, 'rb')
        @filename = filename
        parse_file(file)
      end

      def statistics
        StatisticsPresenter.call(self)
      end

      def dump_frames
        FramesPresenter.call(self)
      end

      def dump_movement
        FramesPresenter.call(self, movement_only: true)
      end

      def details
        DetailsPresenter.call(self)
      end

      private

      def parse_file(file)
        @version = :unknown # Not in this format
        parse_details(file)
        parse_players(file)
        parse_frames(file)
      end

      def parse_details(file)
        @skill         = file.getbyte + 1
        @episode       = file.getbyte
        @level         = file.getbyte
        @play_mode     = :unknown # Not in this format
        @point_of_view = :unknown # Not in this format
        @fast          = :unknown # Not in this format
      end

      def parse_players(file)
        @player_1 = file.getbyte

        # vvHeretic special flags hidden in player_1 byte
        @respawn    = @player_1 & 0x20 != 0
        @longtics   = @player_1 & 0x10 != 0
        @nomonsters = @player_1 & 0x02 != 0

        @player_2 = file.getbyte
        @player_3 = file.getbyte
        @player_4 = file.getbyte
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
