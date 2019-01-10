module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo)
        puts 'Run Strafe Turn Pause Save Fire Use Weapon'
        demo.frames.each do |frame|
          puts dump(frame)
        end
      end

      private

      def dump(frame)
        [
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
