module LMP
  module Statistics
    class Base
      def refresh
        # nothing to do by default
      end

      private

      def none_or_value(x)
        x == 0 ? 'None' : x
      end
    end
  end
end
