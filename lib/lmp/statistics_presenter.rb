module LMP
  module StatisticsPresenter
    extend self

    def call(statistics)
      puts '--------'
      puts 'Statistics:'

      statistics.each(&:print)
    end
  end
end
