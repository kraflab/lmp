require_relative 'doom/demo'

module LMP
  module Doom
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
