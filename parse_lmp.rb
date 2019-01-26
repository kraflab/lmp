require_relative 'lib/lmp'

module ParseLMP
  extend self

  def call(args)
    options = LMP::Options.new(args)
    filenames = args
    filenames.each do |filename|
      demo = LMP.read(filename)
      stats = analyze(demo, options)
      print_analysis(demo, stats, options)
    end

    print_aggregate_stats if options.aggregate_stats?
  end

  private

  def analyze(demo, options)
    @stats = nil unless options.aggregate_stats?
    @stats =
      LMP::Statistics.analyze(
        demo,
        options,
        statistic_blocks: @stats
      )
  end

  def print_analysis(demo, stats, options)
    return if options.aggregate_stats?

    puts '--- START ---'
    LMP::Presenter.call(demo, stats, options)
    puts '--- END ---'
  end

  def print_aggregate_stats
    puts '--- START ---'
    LMP::StatisticsPresenter.call(@stats)
    puts '--- END ---'
  end
end

ParseLMP.call(ARGV)
