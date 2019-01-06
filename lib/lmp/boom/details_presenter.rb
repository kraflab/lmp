module LMP
  module Boom
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Engine: Boom
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
          Player 1: #{demo.player_1}
          Player 2: #{demo.player_2}
          Player 3: #{demo.player_3}
          Player 4: #{demo.player_4}
        EOF
      end
    end
  end
end
