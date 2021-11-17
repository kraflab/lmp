require_relative 'details_presenter'

module LMP
  module MBF21
    class Demo < MBF::Demo
      def details
        DetailsPresenter.call(self)
      end

      private

      def parse_details(file)
        validate_signature(file)
        @skill             = file.getbyte + 1
        @episode           = file.getbyte
        @level             = file.getbyte
        @play_mode         = read_play_mode(file)
        @console_player    = file.getbyte
        @monsters_remember = file.getbyte
        @weapon_recoil     = file.getbyte
        @player_bob        = file.getbyte
        @respawn           = file.getbyte
        @fast              = file.getbyte
        @nomonsters        = file.getbyte
        @seed              = read_seed(file)

        @monster_infighting    = file.getbyte
        @player_helpers        = file.getbyte
        @friend_distance       = read_friend_distance(file)
        @monster_backing       = file.getbyte
        @monster_avoid_hazards = file.getbyte
        @monster_friction      = file.getbyte
        @help_friends          = file.getbyte
        @dog_jumping           = file.getbyte
        @climb_steep_stairs    = file.getbyte

        # TODO: set values for detail presenter
        comp_count = file.getbyte
        puts comp_count
        file.read(comp_count)
      end
    end
  end
end
