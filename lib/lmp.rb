require_relative 'lmp/vanilla/demo'
require_relative 'lmp/boom'
require_relative 'lmp/doom'

puts "#{ARGV[0]}:\n\n"

begin
  lmp = LMP::Boom.read(ARGV[0])
  lmp.details if ARGV[1]
  lmp.statistics
rescue LMP::Boom::Demo::InvalidSignature
  lmp = LMP::Doom.read(ARGV[0])
  lmp.details if ARGV[1]
  lmp.statistics
end
