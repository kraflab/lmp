require_relative 'heretic/demo'

module LMP
  module Heretic
    extend self

    def read(filename)
      Demo.new(filename)
    end
  end
end
