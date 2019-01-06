require_relative 'frame'
require_relative 'statistics_presenter'
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
                  :player_3, :player_4, :frames, :filename

      def initialize(filename)
        file = File.open(filename)
        @filename = filename
        parse_file(file)
      end

      def statistics
        StatisticsPresenter.call(self)
      end

      def dump_frames
        FramesPresenter.call(self)
      end

      private

      def parse_file(file)
        @version = file.getbyte
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
          frame = Frame.new(file)
          break if frame.end_of_frames? || file.eof?
          @frames << frame
        end
      end

      def read_play_mode(file)
        PLAY_MODE.fetch(file.getbyte, 'unknown')
      end
    end
  end
end
