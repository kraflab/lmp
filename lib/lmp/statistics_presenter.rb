module LMP
  module StatisticsPresenter
    extend self

    def call(statistic_blocks)
      print_statistics_header
      print_statistic_blocks(statistic_blocks)
      print_statistic_instances(statistic_blocks)
    end

    private

    def print_statistics_header
      puts <<~EOF
        --------
        Statistics:

      EOF
    end

    def print_statistic_blocks(statistic_blocks)
      statistic_blocks.each do |statistics|
        statistics.each(&:print)
        puts ''
      end
    end

    def print_statistic_instances(statistic_blocks)
      statistics_file = File.open('log.txt', 'w')
      statistic_blocks.each do |statistics|
        statistics.each do |statistic|
          statistic.print_instances(statistics_file)
        end
      end
    end
  end
end
