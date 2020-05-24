require_relative 'frame_presenter'

module LMP
  module Hexen
    class Frame < Heretic::Frame
      attr_reader :suicide, :jump

      def to_s(options = {})
        FramePresenter.call(self, options)
      end

      private

      def parse_artifacts(file)
        artifact_byte = file.getbyte

        # lower 6 bits cover artifact / puzzle item usage
        # bit 7 is suicide
        # bit 8 is jump

        @artifact = artifact_byte & 63
        @artifact = false if artifact == 0
        @suicide = artifact_byte & 64 != 0
        @jump = artifact_byte & 128 != 0
      end
    end
  end
end
