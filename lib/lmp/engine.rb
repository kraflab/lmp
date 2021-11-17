module LMP
  module Engine
    extend self

    SIGNATURE = {
      'B' => :boom,
      'M' => :mbf
    }.freeze

    def detect(filename)
      file = File.open(filename, 'rb')
      version = file.getbyte

      # If it predates versioning, this is the skill field (0 - 4)
      return :unknown if version < 5

      if version == 255
        file.read(26)
        version = file.getbyte
      end

      signature = file.getbyte == 0x1D ? SIGNATURE[file.getbyte.chr] : :doom

      version == 221 && signature == :mbf ? :mbf21 : signature
    end
  end
end
