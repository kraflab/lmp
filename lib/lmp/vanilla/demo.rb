require_relative 'frame'

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
                  :player_3, :player_4, :frames

      def initialize(filename)
        file = File.open(filename)
        parse_file(file)
      end

      def statistics
        sr40_count = 0
        sr50_count = 0
        sr45_count = 0
        moving_count = 0
        turning_count = 0
        run_hist = {}
        strafe_hist = {}
        turn_hist = {}

        frames.each do |frame|
          moving_count += 1 if frame.moving?
          turning_count += 1 if frame.turning?
          sr40_count += 1 if frame.sr40?
          sr50_count += 1 if frame.sr50?
          sr45_count += 1 if frame.sr45?
          run_hist[frame.run.abs] ||= 0
          run_hist[frame.run.abs] += 1
          strafe_hist[frame.strafe.abs] ||= 0
          strafe_hist[frame.strafe.abs] += 1
          turn_hist[frame.turn.abs] ||= 0
          turn_hist[frame.turn.abs] += 1
        end

        puts ''
        puts 'Statistics:'
        puts ''

        puts "SR40: #{(100 * sr40_count / moving_count).to_s.rjust(3)} %"
        puts "SR50: #{(100 * sr50_count / moving_count).to_s.rjust(3)} %"
        puts "SR45: #{(100 * sr45_count / moving_count).to_s.rjust(3)} %" if (100 * sr45_count / moving_count) > 0
        puts "SR:   #{(100 * (sr40_count + sr50_count + sr45_count) / moving_count).to_s.rjust(3)} %"

        puts ''

        puts 'Run Frequency:'
        run_hist.delete(0)
        run_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / moving_count).round(4)}"
        end

        puts ''

        puts 'Strafe Frequency:'
        strafe_hist.delete(0)
        strafe_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / moving_count).round(4)}"
        end

        puts ''

        puts 'Turn Frequency:'
        turn_hist.delete(0)
        turn_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / turning_count).round(4)}"
        end
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
