require 'optparse'

module LMP
  class Options
    def initialize(args)
      @print_details = false
      @print_statistics = false
      @dump_frames = false
      @dump_movement = false
      @aggregate_stats = false
      @turn_markov_chain = false
      @turn_start_distribution = false
      @route_trace = false
      parse(args)
    end

    def print_details?
      @print_details
    end

    def print_statistics?
      @print_statistics
    end

    def dump_frames?
      @dump_frames
    end

    def dump_movement?
      @dump_movement
    end

    def aggregate_stats?
      @aggregate_stats
    end

    def turn_markov_chain?
      @turn_markov_chain
    end

    def turn_start_distribution?
      @turn_start_distribution
    end

    def route_trace?
      @route_trace
    end

    def raw_data?
      dump_movement? || dump_frames?
    end

    private

    def print_details_option(parser)
      parser.on('-d', '--print-details', 'Print demo (header) details') do
        @print_details = true
      end
    end

    def print_statistics_option(parser)
      parser.on('-s', '--print-statistics', 'Print demo statistics') do
        @print_statistics = true
      end
    end

    def dump_frames_option(parser)
      parser.on('-f', '--dump-frames', 'Dump demo frames') do
        @dump_frames = true
      end
    end

    def dump_movement_option(parser)
      parser.on('-m', '--dump-movement', 'Dump demo frames (only movement)') do
        @dump_movement = true
      end
    end

    def aggregate_stats_option(parser)
      parser.on('-a', '--aggregate-stats', 'Aggregate demo stats') do
        @aggregate_stats = true
      end
    end

    def turn_markov_chain_option(parser)
      parser.on('--turn-markov-chain', 'Run turn markov chain analysis') do
        @turn_markov_chain = true
      end
    end

    def turn_start_distribution_option(parser)
      parser.on('--turn-start-distribution', 'Run turn start distribution analysis') do
        @turn_start_distribution = true
      end
    end

    def route_trace_option(parser)
      parser.on('--route-trace', 'Trace the player route in the demo') do
        @route_trace = true
      end
    end

    def help_option(parser)
      parser.on('-h', '--help', 'Print this help') do
        puts parser
        exit
      end
    end

    def explain_statistics_option(parser)
      parser.on('-x', '--explain-statistics', 'Explain statistics') do
        LMP::ExplainStatistics.call
        exit
      end
    end

    def parse(args)
      OptionParser.new do |parser|
        parser.banner = "Usage: parse_lmp.rb [options] file [file2 ...]"
        print_details_option(parser)
        print_statistics_option(parser)
        dump_frames_option(parser)
        dump_movement_option(parser)
        aggregate_stats_option(parser)
        turn_markov_chain_option(parser)
        turn_start_distribution_option(parser)
        route_trace_option(parser)
        explain_statistics_option(parser)
        help_option(parser)
      end.parse!(args)
    end
  end
end
