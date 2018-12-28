require_relative 'lmp/engine'
require_relative 'lmp/vanilla/demo'
require_relative 'lmp/boom'
require_relative 'lmp/mbf'
require_relative 'lmp/doom'

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

filename = ARGV[0]
print_details = ARGV[1]
demo = LMP.read(filename)

puts "#{filename}:\n\n"
demo.details if print_details
demo.statistics
