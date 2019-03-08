module LMP
  module Vanilla
    module FramePresenter
      extend self

      def call(frame)
        start = [
          formatted_index(frame.index),
          formatted_speeds(frame)
        ].join(' ')

        "#{start} | #{formatted_extra(frame)}"
      end

      private

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
