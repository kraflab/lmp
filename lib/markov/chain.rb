module Markov
  class Chain
    attr_reader :states

    def initialize
      @states = {}
    end

    def record_transition(initial, destination)
      @states[initial] ||= State.new(initial)
      @states[initial].record_transition(destination)
    end

    class State
      attr_reader :initial_state, :destination_states, :transition_count

      def initialize(initial)
        @initial_state = initial
        @destination_states = {}
        @transition_count = 0
      end

      def record_transition(destination)
        @transition_count += 1
        @destination_states[destination] ||= 0
        @destination_states[destination] += 1
      end
    end
  end
end
