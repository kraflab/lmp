require_relative 'lib/lmp'

filename = ARGV[-1]
options = LMP::Options.new(ARGV)
demo = LMP.read(filename)
statistics = LMP::Statistics.analyze(demo, options)
LMP::Presenter.call(demo, statistics, options)
