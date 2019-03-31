module LMP
  module Plot
    module RouteTrace
      extend self

      def plot(filename)
        IO.popen('gnuplot', 'w') { |io| io.puts commands(filename) }
      end

      def commands(filename)
        [
          'set title "Route Trace"',
          'set xlabel "X (initial facing direction)"',
          'set ylabel "Y"',
          'set terminal pngcairo size 640, 480',
          'unset key',
          "load 'palettes/viridis.pal'",
          "set output '#{filename.gsub('txt', 'png')}'",
          "plot '#{filename}' with lines lw 2"
        ]
      end
    end
  end
end
