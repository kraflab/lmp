require_relative 'mbf21/demo'

module LMP
  module MBF21
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
