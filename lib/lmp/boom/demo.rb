require_relative 'details_presenter'

module LMP
  module Boom
    class Demo
      class InvalidSignature < StandardError; end

      include LMP::Vanilla::Demo

      attr_reader :compatibility, :console_player, :monsters_remember,
                  :variable_friction, :weapon_recoil, :allow_pushers,
                  :player_bob, :demo_insurance, :seed

      def details
        DetailsPresenter.call(self)
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
