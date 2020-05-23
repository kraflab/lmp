module LMP
  module Heretic
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Engine: Heretic
          Skill: #{demo.skill}
          Episode: #{demo.episode}
          Level: #{demo.level}
          Respawn: #{demo.respawn}
          NoMonsters: #{demo.nomonsters}
          Player 1: #{demo.player_1}
          Player 2: #{demo.player_2}
          Player 3: #{demo.player_3}
          Player 4: #{demo.player_4}
        EOF
      end
    end
  end
end
