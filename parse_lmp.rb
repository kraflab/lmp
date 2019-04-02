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
      run_deep_analyses(demo, options)
    end

    print_aggregate_stats if options.aggregate_stats?
    report_deep_analyses
  end

  private

  def run_deep_analyses(demo, options)
    LMP::Analysis.run(demo, options)
  end

  def report_deep_analyses
    LMP::Analysis.report
  end

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

    puts '--- START ---' unless options.raw_data?
    LMP::Presenter.call(demo, stats, options)
    puts '--- END ---' unless options.raw_data?
  end

  def print_aggregate_stats
    puts '--- START ---'
    LMP::StatisticsPresenter.call(@stats)
    puts '--- END ---'
  end
end

ParseLMP.call(ARGV)
