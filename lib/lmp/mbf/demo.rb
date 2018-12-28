module LMP
  module MBF
    class Demo < Boom::Demo
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
        parse_mbf_details(file)
        file.read(10) # unused
      end

      def parse_mbf_details(file)
        @monster_infighting    = file.getbyte
        @player_helpers        = file.getbyte
        @classic_bfg           = file.getbyte
        @beta_emulation        = file.getbyte
        @friend_distance       = read_friend_distance(file)
        @monster_backing       = file.getbyte
        @monster_avoid_hazards = file.getbyte
        @monster_friction      = file.getbyte
        @help_friends          = file.getbyte
        @dog_jumping           = file.getbyte
        @climb_steep_stairs    = file.getbyte
        @comp_telefrag         = file.getbyte
        @comp_dropoff          = file.getbyte
        @comp_vil              = file.getbyte
        @comp_pain             = file.getbyte
        @comp_skull            = file.getbyte
        @comp_blazing          = file.getbyte
        @comp_doorlight        = file.getbyte
        @comp_model            = file.getbyte
        @comp_god              = file.getbyte
        @comp_falloff          = file.getbyte
        @comp_floors           = file.getbyte
        @comp_skymap           = file.getbyte
        @comp_pursuit          = file.getbyte
        @comp_doorstuck        = file.getbyte
        @comp_staylift         = file.getbyte
        @comp_zombie           = file.getbyte
        @comp_stairs           = file.getbyte
        @comp_infcheat         = file.getbyte
        @comp_zerotags         = file.getbyte
        @comp_moveblock        = file.getbyte
        @comp_respawn          = file.getbyte
        @comp_sound            = file.getbyte
        @comp_666              = file.getbyte
        @comp_soul             = file.getbyte
        @comp_maskedanim       = file.getbyte
        @comp_ouchface         = file.getbyte
        @comp_maxhealth        = file.getbyte
        @comp_translucency     = file.getbyte
      end

      def read_friend_distance(file)
        file.read(2).unpack('N')[0]
      end

      def validate_signature(file)
        raise InvalidSignature unless file.getbyte == 0x1D
        raise InvalidSignature unless file.read(3) == 'MBF'
        raise InvalidSignature unless file.getbyte == 0xE6
        raise InvalidSignature unless file.getbyte == 0x00
      end
    end
  end
end
