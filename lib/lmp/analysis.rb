require_relative 'analysis/base'
require_relative 'analysis/turn_markov_chain'
require_relative 'analysis/turn_start_distribution'
require_relative 'analysis/route_trace'
require_relative 'analysis/turn_frequency'

module LMP
  module Analysis
    extend self

    def run(demo, options)
      initialize_analyses(options) if @analyses.nil?
      @analyses.each { |a| a.run(demo) }
    end

    def report
      filename_root = "analysis_#{Time.now.to_i.to_s}_"
      @analyses.each { |a| a.report(filename_root) }
    end

    private

    def initialize_analyses(options)
      @analyses = []
      @analyses << TurnMarkovChain.new if options.turn_markov_chain?
      @analyses << TurnStartDistribution.new if options.turn_start_distribution?
      @analyses << RouteTrace.new if options.route_trace?
      @analyses << TurnFrequency.new if options.turn_frequency?
    end
  end
end
