require_relative 'details_presenter'

module LMP
  module MBF
    class Demo < Boom::Demo
      attr_reader :monster_infighting, :player_helpers, :classic_bfg,
                  :beta_emulation, :friend_distance, :monster_backing,
                  :monster_avoid_hazards, :monster_friction, :help_friends,
                  :dog_jumping, :climb_steep_stairs, :comp_telefrag,
                  :comp_dropoff, :comp_vil, :comp_pain, :comp_skull,
                  :comp_blazing, :comp_doorlight, :comp_model, :comp_god,
                  :comp_falloff, :comp_floors, :comp_skymap, :comp_pursuit,
                  :comp_doorstuck, :comp_staylift, :comp_zombie, :comp_stairs,
                  :comp_infcheat, :comp_zerotags, :comp_moveblock,
                  :comp_respawn, :comp_sound, :comp_666, :comp_soul,
                  :comp_maskedanim, :comp_ouchface, :comp_maxhealth,
                  :comp_translucency

      def details
        DetailsPresenter.call(self)
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
