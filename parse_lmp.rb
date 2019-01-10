require_relative 'lib/lmp'

module ParseLMP
  extend self

  def call(args)
    options = LMP::Options.new(args)
    filenames = args
    filenames.each do |filename|
      demo = LMP.read(filename)
      statistics = LMP::Statistics.analyze(demo, options)
      puts '--- START ---'
      LMP::Presenter.call(demo, statistics, options)
      puts '--- END ---'
    end
  end
end

ParseLMP.call(ARGV)
