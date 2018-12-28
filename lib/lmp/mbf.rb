require_relative 'mbf/demo'

module LMP
  module MBF
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
