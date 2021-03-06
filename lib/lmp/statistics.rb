require_relative 'statistics/base'
require_relative 'statistics/turn_frequency'
require_relative 'statistics/straferun_frequency'
require_relative 'statistics/turbo'
require_relative 'statistics/stroller'
require_relative 'statistics/sr50_on_turns'
require_relative 'statistics/one_frame_turns'
require_relative 'statistics/sudden_turns'
require_relative 'statistics/average_turn_speed'
require_relative 'statistics/one_frame_uses'
require_relative 'statistics/one_frame_fires'
require_relative 'statistics/one_frame_swaps'
require_relative 'statistics/pauses'
require_relative 'statistics/saves'
require_relative 'statistics/bad_straferun'

module LMP
  module Statistics
    extend self

    def analyze(demo, options, statistic_blocks: nil)
      statistic_blocks ||= new_statistic_blocks
      refresh_stats(statistic_blocks)
      analyze_demo(demo, options, statistic_blocks)
      statistic_blocks
    end

    private

    def refresh_stats(statistic_blocks)
      statistic_blocks.each do |statistics|
        statistics.each { |s| s.refresh }
      end
    end

    def analyze_demo(demo, options, statistic_blocks)
      demo.frames.each do |frame|
        statistic_blocks.each do |statistics|
          statistics.each { |s| s.analyze_frame(frame) }
        end
      end
    end

    def new_statistic_blocks
      [
        [
          Statistics::StraferunFrequency.new
        ],
        [
          Statistics::TurnFrequency.new
        ],
        [
          Statistics::AverageTurnSpeed.new
        ],
        [
          Statistics::Turbo.new,
          Statistics::Stroller.new,
          Statistics::SR50OnTurns.new,
          Statistics::OneFrameUses.new,
          Statistics::OneFrameFires.new,
          Statistics::OneFrameSwaps.new,
          Statistics::Pauses.new,
          Statistics::Saves.new
        ],
        [
          Statistics::OneFrameTurns.new
        ],
        [
          Statistics::SuddenTurns.new
        ],
        [
          Statistics::BadStraferun.new
        ]
      ]
    end
  end
end
