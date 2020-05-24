require_relative 'hexen/demo'

module LMP
  module Hexen
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
