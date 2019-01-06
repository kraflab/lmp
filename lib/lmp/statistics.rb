require_relative 'statistics/turn_frequency'
require_relative 'statistics/straferun_frequency'
require_relative 'statistics/notes'
require_relative 'statistics/one_frame_turns'
require_relative 'statistics/sudden_turns'

module LMP
  module Statistics
    extend self

    def analyze(demo, options)
      statistics = [
        Statistics::StraferunFrequency.new,
        Statistics::TurnFrequency.new,
        Statistics::Notes.new,
        Statistics::OneFrameTurns.new,
        Statistics::SuddenTurns.new
      ]

      demo.frames.each do |frame|
        statistics.each { |s| s.analyze_frame(frame) }
      end

      statistics
    end
  end
end
