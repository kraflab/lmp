module LMP
  module Vanilla
    module FramesPresenter
      extend self

      def call(demo)
        puts 'Frame Run Strafe Turn Extra'
        demo.frames.each_with_index do |frame, index|
          puts dump(frame, index)
        end
      end

      private

      def dump(frame, index)
        start = [
          formatted_index(index),
          formatted_speeds(frame)
        ].join(' ')

        "#{start} | #{formatted_extra(frame)}"
      end

      def formatted_index(index)
        index = index.to_s.rjust(5)
      end

      def formatted_speeds(frame)
        [
          frame.run,
          frame.strafe,
          frame.turn
        ].map { |x| x.to_s.rjust(4) }.join(' ')
      end

      def formatted_extra(frame)
        extra = [
          frame.pause ? 'pause' : nil,
          frame.save ? 'save' : nil,
          frame.fire ? 'fire' : nil,
          frame.use ? 'use' : nil,
          frame.weapon ? "weapon(#{frame.weapon})" : nil
        ].reject(&:nil?).join(' ')

        extra.length > 0 ? extra : '-'
      end
    end
  end
end
