require_relative 'statistics/turn_frequency'
require_relative 'statistics/straferun_frequency'
require_relative 'statistics/turbo'
require_relative 'statistics/stroller'
require_relative 'statistics/sr50_on_turns'
require_relative 'statistics/one_frame_turns'
require_relative 'statistics/sudden_turns'

module LMP
  module Statistics
    extend self

    def analyze(demo, options)
      statistic_blocks = [
        [
          Statistics::StraferunFrequency.new
        ],
        [
          Statistics::TurnFrequency.new
        ],
        [
          Statistics::Turbo.new,
          Statistics::Stroller.new,
          Statistics::SR50OnTurns.new
        ],
        [
          Statistics::OneFrameTurns.new
        ],
        [
          Statistics::SuddenTurns.new
        ]
      ]

      demo.frames.each do |frame|
        statistic_blocks.each do |statistics|
          statistics.each { |s| s.analyze_frame(frame) }
        end
      end

      statistic_blocks
    end
  end
end
