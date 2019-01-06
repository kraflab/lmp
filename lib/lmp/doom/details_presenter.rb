module LMP
  module Doom
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Engine: Doom
          Version: #{demo.version}
          Skill: #{demo.skill}
          Episode: #{demo.episode}
          Level: #{demo.level}
          Play Mode: #{demo.play_mode}
          Respawn: #{demo.respawn}
          Fast: #{demo.fast}
          NoMonsters: #{demo.nomonsters}
          Point of View: #{demo.point_of_view}
          Player 1: #{demo.player_1}
          Player 2: #{demo.player_2}
          Player 3: #{demo.player_3}
          Player 4: #{demo.player_4}
        EOF
      end
    end
  end
end
