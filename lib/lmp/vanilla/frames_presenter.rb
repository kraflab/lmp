module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo)
        puts 'Frame Run Strafe Turn Pause Save Fire Use Weapon'
        demo.frames.each_with_index do |frame, index|
          puts dump(frame, index)
        end
      end

      private

      def dump(frame, index)
        [
          index,
          frame.run,
          frame.strafe,
          frame.turn,
          frame.pause,
          frame.save,
          frame.fire,
          frame.use,
          frame.weapon
        ].map(&:to_s).join(' ')
      end
    end
  end
end
