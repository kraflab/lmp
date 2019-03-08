module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo)
        puts 'Frame Run Strafe Turn Extra'
        demo.frames.each do |frame|
          puts frame.to_s
        end
      end
    end
  end
end
