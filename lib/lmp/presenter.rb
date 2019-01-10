require_relative 'statistics_presenter'

module LMP
  module Presenter
    extend self

    def call(demo, statistic_blocks, options)
      return demo.dump_frames if options.dump_frames?

      puts "File: #{demo.filename}"
      demo.details if options.print_details?
      StatisticsPresenter.call(statistic_blocks) if options.print_statistics?
    end
  end
end
