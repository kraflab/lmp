module LMP
  module Vanilla
    class FramePresenter
      def self.call(frame, options = {})
        new(frame, options).call
      end

      def initialize(frame, options = {})
        @frame = frame
        @options = options
      end

      def call
        start = [
          formatted_index,
          formatted_speeds
        ].join(' ')

        return start if options[:movement_only]

        "#{start} | #{formatted_extra}"
      end

      private

      attr_reader :frame, :options

      def formatted_index
        frame.index.to_s.rjust(5)
      end

      def formatted_speeds
        [
          frame.run,
          frame.strafe,
          frame.turn
        ].map { |x| x.to_s.rjust(4) }.join(' ')
      end

      def formatted_extra
        extra = extra_fields.reject(&:nil?).join(' ')

        extra.length > 0 ? extra : '-'
      end

      def extra_fields
        [
          frame.join ? 'join' : nil,
          frame.pause ? 'pause' : nil,
          frame.save ? 'save' : nil,
          frame.fire ? 'fire' : nil,
          frame.use ? 'use' : nil,
          frame.weapon ? "weapon(#{frame.weapon})" : nil
        ]
      end
    end
  end
end
