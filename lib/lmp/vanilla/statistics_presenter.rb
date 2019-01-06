module LMP
  module Vanilla
    module StatisticsPresenter
      extend self

      def call(demo)
        sr40_count = 0
        sr50_count = 0
        sr45_count = 0
        moving_count = 0
        turning_count = 0
        run_hist = {}
        strafe_hist = {}
        turn_hist = {}

        demo.frames.each do |frame|
          moving_count += 1 if frame.moving?
          turning_count += 1 if frame.turning?
          sr40_count += 1 if frame.sr40?
          sr50_count += 1 if frame.sr50?
          sr45_count += 1 if frame.sr45?
          run_hist[frame.run.abs] ||= 0
          run_hist[frame.run.abs] += 1
          strafe_hist[frame.strafe.abs] ||= 0
          strafe_hist[frame.strafe.abs] += 1
          turn_hist[frame.turn.abs] ||= 0
          turn_hist[frame.turn.abs] += 1
        end

        puts '--------'
        puts 'Statistics:'
        puts ''

        puts "SR40: #{(100 * sr40_count / moving_count).to_s.rjust(3)} %"
        puts "SR50: #{(100 * sr50_count / moving_count).to_s.rjust(3)} %"
        puts "SR45: #{(100 * sr45_count / moving_count).to_s.rjust(3)} %" if (100 * sr45_count / moving_count) > 0
        puts "SR:   #{(100 * (sr40_count + sr50_count + sr45_count) / moving_count).to_s.rjust(3)} %"

        puts ''

        puts 'Run Frequency:'
        run_hist.delete(0)
        run_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / moving_count).round(4)}"
        end

        puts ''

        puts 'Strafe Frequency:'
        strafe_hist.delete(0)
        strafe_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / moving_count).round(4)}"
        end

        puts ''

        puts 'Turn Frequency:'
        turn_hist.delete(0)
        turn_hist.sort.each do |k, v|
          puts "  #{k.to_s.rjust(3)}: #{(v.to_f / turning_count).round(4)}"
        end
      end
    end
  end
end
