module LMP
  module Statistics
    class Base
      private

      def none_or_value(x)
        x == 0 ? 'None' : x
      end
    end
  end
end
