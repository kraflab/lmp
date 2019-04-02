module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo, options = {})
        puts 'Frame Run Strafe Turn Extra' unless options[:dump_movement]
        demo.frames.each do |frame|
          puts frame.to_s(options)
        end
      end
    end
  end
end
