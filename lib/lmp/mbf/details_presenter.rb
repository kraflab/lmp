module LMP
  module MBF
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Version: #{demo.version}
          Compatibility: #{demo.compatibility}
          Skill: #{demo.skill}
          Episode: #{demo.episode}
          Level: #{demo.level}
          Play Mode: #{demo.play_mode}
          Console Player: #{demo.console_player}
          Monsters Remember: #{demo.monsters_remember}
          Variable Friction: #{demo.variable_friction}
          Weapon Recoil: #{demo.weapon_recoil}
          Allow Pushers: #{demo.allow_pushers}
          Player Bob: #{demo.player_bob}
          Respawn: #{demo.respawn}
          Fast: #{demo.fast}
          NoMonsters: #{demo.nomonsters}
          Demo Insurance: #{demo.demo_insurance}
          Seed: #{demo.seed}
          Monster Infighting: #{demo.monster_infighting}
          Player Helpers: #{demo.player_helpers}
          Classic BFG: #{demo.classic_bfg}
          Beta Emulation: #{demo.beta_emulation}
          Friend Distance: #{demo.friend_distance}
          Monster Backing: #{demo.monster_backing}
          Monster Avoid Hazards: #{demo.monster_avoid_hazards}
          Monster Friction: #{demo.monster_friction}
          Help Friends: #{demo.help_friends}
          Dog Jumping: #{demo.dog_jumping}
          Climb Steep Stairs: #{demo.climb_steep_stairs}
          Comp Telefrag: #{demo.comp_telefrag}
          Comp Dropoff: #{demo.comp_dropoff}
          Comp Vil: #{demo.comp_vil}
          Comp Pain: #{demo.comp_pain}
          Comp Skull: #{demo.comp_skull}
          Comp Blazing: #{demo.comp_blazing}
          Comp Doorlight: #{demo.comp_doorlight}
          Comp Model: #{demo.comp_model}
          Comp God: #{demo.comp_god}
          Comp Falloff: #{demo.comp_falloff}
          Comp Floors: #{demo.comp_floors}
          Comp Skymap: #{demo.comp_skymap}
          Comp Pursuit: #{demo.comp_pursuit}
          Comp Doorstuck: #{demo.comp_doorstuck}
          Comp Staylift: #{demo.comp_staylift}
          Comp Zombie: #{demo.comp_zombie}
          Comp Stairs: #{demo.comp_stairs}
          Comp Infcheat: #{demo.comp_infcheat}
          Comp Zerotags: #{demo.comp_zerotags}
          Comp Moveblock: #{demo.comp_moveblock}
          Comp Respawn: #{demo.comp_respawn}
          Comp Sound: #{demo.comp_sound}
          Comp 666: #{demo.comp_666}
          Comp Soul: #{demo.comp_soul}
          Comp Maskedanim: #{demo.comp_maskedanim}
          Comp Ouchface: #{demo.comp_ouchface}
          Comp Maxhealth: #{demo.comp_maxhealth}
          Comp Translucency: #{demo.comp_translucency}
          Player 1: #{demo.player_1}
          Player 2: #{demo.player_2}
          Player 3: #{demo.player_3}
          Player 4: #{demo.player_4}
        EOF
      end
    end
  end
end
