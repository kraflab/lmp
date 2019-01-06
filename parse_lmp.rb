require_relative 'lib/lmp'

filename = ARGV[-1]
options = LMP::Options.new(ARGV)
demo = LMP.read(filename)
LMP::Presenter.call(demo, options)
