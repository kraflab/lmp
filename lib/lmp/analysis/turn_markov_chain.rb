require_relative '../../markov/chain'

module LMP
  module Analysis
    class TurnMarkovChain < Base
      ANALYSIS_NAME = 'turn_markov_chain'
      IGNORE_FRAMES = 2

      def initialize()
        @markov_chain = Markov::Chain.new
      end

      def analyze_frame(frame)
        return if frame.index < IGNORE_FRAMES

        @markov_chain.record_transition(frame.prev_frame.turn, frame.turn)
      end

      def report_to(file)
        (-128..127).each do |initial|
          file.puts state_data(@markov_chain.states[initial])
        end
      end

      def state_data(state)
        return (-128..127).map { '0.0' }.join(' ') if state.nil?

        (-128..127).map do |t|
          count = state.destination_states[t] || 0
          rate = count.to_f / state.transition_count
          rate.to_s
        end.join(' ')
      end
    end
  end
end
