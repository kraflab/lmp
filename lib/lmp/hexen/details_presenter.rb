module LMP
  module Hexen
    module DetailsPresenter
      extend self

      def call(demo)
        puts <<~EOF
          --------
          Details:

          Engine: Hexen
          Skill: #{demo.skill}
          Level: #{demo.level}
          Respawn: #{demo.respawn}
          NoMonsters: #{demo.nomonsters}
          Player 1: #{demo.player_1} (#{demo.player_1_class})
          Player 2: #{demo.player_2} (#{demo.player_2_class})
          Player 3: #{demo.player_3} (#{demo.player_3_class})
          Player 4: #{demo.player_4} (#{demo.player_4_class})
          Player 5: #{demo.player_5} (#{demo.player_5_class})
          Player 6: #{demo.player_6} (#{demo.player_6_class})
          Player 7: #{demo.player_7} (#{demo.player_7_class})
          Player 8: #{demo.player_8} (#{demo.player_8_class})
        EOF
      end
    end
  end
end
