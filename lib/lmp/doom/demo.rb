require_relative 'details_presenter'

module LMP
  module Doom
    class Demo
      include LMP::Vanilla::Demo

      def details
        DetailsPresenter.call(self)
      end

      private

      def parse_details(file)
        @skill         = file.getbyte + 1
        @episode       = file.getbyte
        @level         = file.getbyte
        @play_mode     = read_play_mode(file)
        @respawn       = file.getbyte
        @fast          = file.getbyte
        @nomonsters    = file.getbyte
        @point_of_view = file.getbyte
      end
    end
  end
end
