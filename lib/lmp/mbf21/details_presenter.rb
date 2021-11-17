module LMP
  module MBF21
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Version: #{demo.version}
          Skill: #{demo.skill}
          Episode: #{demo.episode}
          Level: #{demo.level}
          Play Mode: #{demo.play_mode}
          Console Player: #{demo.console_player}
          Monsters Remember: #{demo.monsters_remember}
          Weapon Recoil: #{demo.weapon_recoil}
          Player Bob: #{demo.player_bob}
          Respawn: #{demo.respawn}
          Fast: #{demo.fast}
          NoMonsters: #{demo.nomonsters}
          Seed: #{demo.seed}
          Monster Infighting: #{demo.monster_infighting}
          Player Helpers: #{demo.player_helpers}
          Friend Distance: #{demo.friend_distance}
          Monster Backing: #{demo.monster_backing}
          Monster Avoid Hazards: #{demo.monster_avoid_hazards}
          Monster Friction: #{demo.monster_friction}
          Help Friends: #{demo.help_friends}
          Dog Jumping: #{demo.dog_jumping}
          Climb Steep Stairs: #{demo.climb_steep_stairs}
          Player 1: #{demo.player_1}
          Player 2: #{demo.player_2}
          Player 3: #{demo.player_3}
          Player 4: #{demo.player_4}
        EOF
      end
    end
  end
end
