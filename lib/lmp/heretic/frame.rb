require_relative 'frame_presenter'

module LMP
  module Heretic
    class Frame < Vanilla::Frame
      attr_reader :look, :fly, :artifact

      def initialize(file, longtics, prev_frame, index)
        super
        return if end_of_frames?
        parse_advanced_movement(file)
        parse_artifacts(file)
      end

      def to_s(options = {})
        FramePresenter.call(self, options)
      end

      private

      def parse_advanced_movement(file)
        advanced_movement = file.getbyte

        # looking: lower four bits
        # 0 nothing
        # 1-7 looking up
        # 8 centering view
        # 9-15 looking down (subtract 16)

        # flying: upper four bits
        # 0 nothing
        # 1-7 flying up
        # 8 dropping to ground
        # 9-15 flying down (subtract 16)

        @look = advanced_movement_value(advanced_movement & 15)
        @fly = advanced_movement_value(advanced_movement >> 4)
      end

      def parse_artifacts(file)
        # 0 nothing
        # 1 ring of invulnerability
        # 2 shadowsphere
        # 3 quartz flask
        # 4 mystic urn
        # 5 tome of power
        # 6 torch
        # 7 timebomb of the ancients
        # 8 morph ovum
        # 9 wings of wrath
        # 10 chaos device
        # 255 unsuccessful use attempt

        @artifact = file.getbyte
        @artifact = false if artifact == 0
      end

      def advanced_movement_value(value)
        return false if value == 0 # no input
        return 0 if value == 8 # (land / neutral look)
        return value - 16 if value > 8 # signed 4 bit
        value
      end
    end
  end
end
