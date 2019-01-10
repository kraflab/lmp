require 'optparse'

module LMP
  class Options
    def initialize(args)
      @print_details = false
      @print_statistics = false
      @dump_frames = false
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
        explain_statistics_option(parser)
        help_option(parser)
      end.parse!(args)
    end
  end
end
