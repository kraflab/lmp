module LMP
  module Hexen
    class FramePresenter < Heretic::FramePresenter
      private

      def extra_fields
        super + [
          frame.suicide ? "suicide" : nil,
          frame.jump ? "jump" : nil
        ]
      end
    end
  end
end
