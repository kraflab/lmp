require_relative 'frame'
require_relative 'frames_presenter'

module LMP
  module Vanilla
    module Demo
      PLAY_MODE = {
        0 => 'single / coop',
        1 => 'deathmatch',
        2 => 'altdeath'
      }.freeze

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

      private

      def parse_file(file)
        @version = file.getbyte
        strip_255_wrapper(file)
        @longtics = longtics?
        parse_details(file)
        parse_players(file)
        parse_frames(file)
      end

      def parse_players(file)
        @player_1 = file.getbyte
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

      def read_play_mode(file)
        PLAY_MODE.fetch(file.getbyte, 'unknown')
      end

      def strip_255_wrapper(file)
        if version == 255
          file.read(26)
          @version = file.getbyte
        end
      end

      def longtics?
        @version == 221 ||
          @version == 214 ||
          (@version > 110 && @version < 200)
      end
    end
  end
end
