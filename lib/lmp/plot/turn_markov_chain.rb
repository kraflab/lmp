module LMP
  module Plot
    module TurnMarkovChain
      extend self

      def plot(filename)
        IO.popen('gnuplot', 'w') { |io| io.puts commands(filename) }
      end

      def commands(filename)
        [
          'set title "Turn Markov Chain - Transition Rate"',
          'set xlabel "Turn Speed (to)"',
          'set ylabel "Turn Speed (from)"',
          'set xrange [-64:64]',
          'set yrange [-64:64]',
          'set xtics out 16',
          'set ytics out 16',
          'set tmargin 1',
          'set bmargin 2',
          'set rmargin 1',
          'set lmargin 8',
          'set size square',
          'set view map',
          'set terminal pngcairo size 640, 640',
          'unset key',
          "load 'palettes/viridis.pal'",
          "set output '#{filename.gsub('txt', 'png')}'",
          "plot '#{filename}' u ($1-128):($2-128):($3) matrix with image"
        ]
      end
    end
  end
end
