require_relative 'lmp/boom'

lmp = LMP::Boom.read(ARGV[0])
lmp.details
lmp.statistics
