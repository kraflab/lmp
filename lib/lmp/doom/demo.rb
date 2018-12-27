module LMP
  module Doom
    class Demo
      include LMP::Vanilla::Demo

      attr_reader :point_of_view

      def details
        puts <<~EOF
          Version: #{version}
          Skill: #{skill}
          Episode: #{episode}
          Level: #{level}
          Play Mode: #{play_mode}
          Respawn: #{respawn}
          Fast: #{fast}
          NoMonsters: #{nomonsters}
          Point of View: #{point_of_view}
          Player 1: #{player_1}
          Player 2: #{player_2}
          Player 3: #{player_3}
          Player 4: #{player_4}
        EOF
      end

      private

      def parse_file(file)
        @version = file.getbyte
        @skill = file.getbyte + 1
        @episode = file.getbyte
        @level = file.getbyte
        @play_mode = read_play_mode(file)
        @respawn = file.getbyte
        @fast = file.getbyte
        @nomonsters = file.getbyte
        @point_of_view = file.getbyte
        @player_1 = file.getbyte
        @player_2 = file.getbyte
        @player_3 = file.getbyte
        @player_4 = file.getbyte
        parse_frames(file)
      end
    end
  end
end
