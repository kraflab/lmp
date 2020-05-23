require_relative 'lmp/engine'
require_relative 'lmp/vanilla/demo'
require_relative 'lmp/boom'
require_relative 'lmp/mbf'
require_relative 'lmp/doom'
require_relative 'lmp/heretic'
require_relative 'lmp/options'
require_relative 'lmp/presenter'
require_relative 'lmp/statistics'
require_relative 'lmp/explain_statistics'
require_relative 'lmp/analysis'

module LMP
  ENGINE = {
    doom: Doom,
    boom: Boom,
    mbf: MBF,
    heretic: Heretic
  }.freeze

  extend self

  def read(filename, options)
    engine = LMP::Engine.detect(filename)
    engine = options.engine if engine == :unknown

    bad_engine(filename) unless ENGINE[engine]

    ENGINE[engine].read(filename)
  end

  def bad_engine(filename)
    puts "Unknown engine for #{filename}. Aborting..."
    exit
  end
end
