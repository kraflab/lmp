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

      file.getbyte == 0x1D ? SIGNATURE[file.getbyte.chr] : :doom
    end
  end
end
