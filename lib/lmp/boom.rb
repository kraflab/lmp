require_relative 'boom/demo'

module LMP
  module Boom
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
