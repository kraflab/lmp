module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo)
        puts 'Run Strafe Turn'
        demo.frames.each do |frame|
          puts "#{frame.run} #{frame.strafe} #{frame.turn}"
        end
      end
    end
  end
end
