module LMP
  module Boom
    class Demo
      class InvalidSignature < StandardError; end

      include LMP::Vanilla::Demo

      attr_reader :compatibility, :console_player, :monsters_remember,
                  :variable_friction, :weapon_recoil, :allow_pushers,
                  :player_bob, :demo_insurance, :seed

      def details
        puts <<~EOF
          Details:

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

      private

      def parse_details(file)
        parse_boom_details(file)
        file.read(50) # unused
      end

      def parse_boom_details(file)
        validate_signature(file)
        @compatibility     = file.getbyte
        @skill             = file.getbyte + 1
        @episode           = file.getbyte
        @level             = file.getbyte
        @play_mode         = read_play_mode(file)
        @console_player    = file.getbyte
        @monsters_remember = file.getbyte
        @variable_friction = file.getbyte
        @weapon_recoil     = file.getbyte
        @allow_pushers     = file.getbyte
        @point_of_view     = file.getbyte
        @player_bob        = file.getbyte
        @respawn           = file.getbyte
        @fast              = file.getbyte
        @nomonsters        = file.getbyte
        @demo_insurance    = file.getbyte
        @seed              = read_seed(file)
      end

      def validate_signature(file)
        raise InvalidSignature unless file.getbyte == 0x1D
        raise InvalidSignature unless file.read(4) == 'Boom'
        raise InvalidSignature unless file.getbyte == 0xE6
      end

      def read_seed(file)
        file.read(4).unpack('N')[0]
      end
    end
  end
end
