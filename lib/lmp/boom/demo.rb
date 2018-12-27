module LMP
  module Boom
    class Demo
      class InvalidSignature < StandardError; end

      PLAY_MODE = {
        0 => 'single / coop',
        1 => 'deathmatch',
        2 => 'altdeath'
      }.freeze

      attr_reader :version, :compatibility, :skill, :episode, :level,
                  :play_mode, :console_player, :monsters_remember,
                  :variable_friction, :weapon_recoil, :allow_pushers,
                  :player_bob, :respawn, :fast, :nomonsters, :demo_insurance,
                  :seed, :player_1, :player_2, :player_3, :player_4, :frames


      def initialize(filename)
        file = File.open(filename)
        parse_file(file)
      end

      def details
        puts <<~EOF
          Version: #{version}
          Compatibility: #{compatibility}
          Skill: #{skill}
          Episode: #{episode}
          Level: #{level}
          Play Mode: #{play_mode}
          Console Player: #{console_player}
          Monsters Remember: #{monsters_remember}
          Variable Friction: #{variable_friction}
          Weapon Recoil: #{weapon_recoil}
          Allow Pushers: #{allow_pushers}
          Player Bob: #{player_bob}
          Respawn: #{respawn}
          Fast: #{fast}
          NoMonsters: #{nomonsters}
          Demo Insurance: #{demo_insurance}
          Seed: #{seed}
          Player 1: #{player_1}
          Player 2: #{player_2}
          Player 3: #{player_3}
          Player 4: #{player_4}
        EOF
      end

      def statistics
        sr40_count = 0
        sr50_count = 0
        moving_count = 0
        total_count = 0
        run_hist = {}
        strafe_hist = {}
        turn_hist = {}

        frames.each do |frame|
          total_count += 1
          moving_count += 1 if frame.moving?
          sr40_count += 1 if frame.sr40?
          sr50_count += 1 if frame.sr50?
          run_hist[frame.run] ||= 0
          run_hist[frame.run] += 1
          strafe_hist[frame.strafe] ||= 0
          strafe_hist[frame.strafe] += 1
          turn_hist[frame.turn] ||= 0
          turn_hist[frame.turn] += 1
        end

        puts <<~EOF
          SR40: #{100 * sr40_count / moving_count} %
          SR50: #{100 * sr50_count / moving_count} %
          Move: #{100 * moving_count / total_count} %
        EOF

        puts ''

        puts 'Run Histogram:'
        run_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{v}"
        end

        puts ''

        puts 'Strafe Histogram:'
        strafe_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{v}"
        end

        puts ''

        puts 'Turn Histogram:'
        turn_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(4)}: #{v}"
        end
      end

      private

      def parse_file(file)
        @version = file.getbyte
        validate_signature(file)
        @compatibility = file.getbyte
        @skill = file.getbyte
        @episode = file.getbyte
        @level = file.getbyte
        @play_mode = read_play_mode(file)
        @console_player = file.getbyte
        @monsters_remember = file.getbyte
        @variable_friction = file.getbyte
        @weapon_recoil = file.getbyte
        @allow_pushers = file.getbyte
        file.getbyte # unused
        @player_bob = file.getbyte
        @respawn = file.getbyte
        @fast = file.getbyte
        @nomonsters = file.getbyte
        @demo_insurance = file.getbyte
        @seed = read_seed(file)
        file.read(50) # unused
        @player_1 = file.getbyte
        @player_2 = file.getbyte
        @player_3 = file.getbyte
        @player_4 = file.getbyte
        parse_frames(file)
      end

      def parse_frames(file)
        @frames = []

        loop do
          frame = Frame.new(file)
          break if frame.end_of_frames? || file.eof?
          @frames << frame
        end
      end

      def validate_signature(file)
        raise InvalidSignature unless file.getbyte == 0x1D
        raise InvalidSignature unless file.read(4) == 'Boom'
        raise InvalidSignature unless file.getbyte == 0xE6
      end

      def read_play_mode(file)
        PLAY_MODE.fetch(file.getbyte, 'unknown')
      end

      def read_seed(file)
        file.read(4).unpack('N')[0]
      end
    end
  end
end
