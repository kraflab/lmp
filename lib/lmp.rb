require_relative 'lmp/engine'
require_relative 'lmp/vanilla/demo'
require_relative 'lmp/boom'
require_relative 'lmp/mbf'
require_relative 'lmp/doom'
require_relative 'lmp/options'
require_relative 'lmp/presenter'

module LMP
  ENGINE = {
    doom: Doom,
    boom: Boom,
    mbf: MBF
  }.freeze

  extend self

  def read(filename)
    engine = LMP::Engine.detect(filename)
    ENGINE[engine].read(filename)
  end
end
