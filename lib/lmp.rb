require_relative 'lmp/engine'
require_relative 'lmp/vanilla/demo'
require_relative 'lmp/boom'
require_relative 'lmp/mbf'
require_relative 'lmp/doom'
require_relative 'lmp/options'
require_relative 'lmp/presenter'
require_relative 'lmp/statistics'
require_relative 'lmp/explain_statistics'

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
