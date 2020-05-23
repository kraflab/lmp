require_relative 'frame_presenter'

module LMP
  module Heretic
    class Frame < Vanilla::Frame
      def initialize(file, longtics, prev_frame, index)
        super
        return if end_of_frames?
        parse_advanced_movement(file)
        parse_artifacts(file)
      end

      private

      def parse_advanced_movement(file)
        file.getbyte # ignoring for now

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
      end

      def parse_artifacts(file)
        file.getbyte # ignoring for now

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
      end
    end
  end
end
