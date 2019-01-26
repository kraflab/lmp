module LMP
  module Engine
    extend self

    SIGNATURE = {
      'B' => :boom,
      'M' => :mbf
    }.freeze

    def detect(filename)
      file = File.open(filename, 'rb')
      file.getbyte # version
      file.getbyte == 0x1D ? SIGNATURE[file.getbyte.chr] : :doom
    end
  end
end
