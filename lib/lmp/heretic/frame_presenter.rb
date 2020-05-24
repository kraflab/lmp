module LMP
  module Heretic
    class FramePresenter < Vanilla::FramePresenter
      private

      def extra_fields
        super + [
          frame.look ? "look(#{frame.look})" : nil,
          frame.fly ? "fly(#{frame.fly})" : nil,
          frame.artifact ? "artifact(#{frame.artifact})" : nil
        ]
      end
    end
  end
end
