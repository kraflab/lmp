module LMP
  module Statistics
    class Base
      VERBOSE_STAT_WINDOW = 2
      STAT_NAME = 'UNDEFINED'

      def refresh
        # nothing to do by default
      end

      def print_instances(file)
        return if @instances.nil?

        file.puts '--------'
        file.puts self.class::STAT_NAME
        file.puts ''
        file.puts @instances.join("\n\n")
      end

      private

      def none_or_value(x)
        x == 0 ? 'None' : x
      end

      def capture_instance(frame)
        @instances ||= []
        @instances << frame.frame_window(self.class::VERBOSE_STAT_WINDOW).join("\n")
      end
    end
  end
end
