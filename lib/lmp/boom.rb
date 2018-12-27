require_relative 'boom/demo'
require_relative 'boom/frame'

module LMP
  module Boom
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
