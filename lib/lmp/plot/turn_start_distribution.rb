module LMP
  module Plot
    module TurnStartDistribution
      extend self

      def plot(filename)
        IO.popen('gnuplot', 'w') { |io| io.puts commands(filename) }
      end

      def commands(filename)
        [
          'set title "Turn Start Distribution"',
          'set xlabel "Turn Speed (second frame)"',
          'set ylabel "Turn Speed (first frame)"',
          'set xrange [-16:16]',
          'set yrange [-16:16]',
          'set xtics out 4',
          'set ytics out 4',
          'set tmargin 1',
          'set bmargin 2',
          'set rmargin 1',
          'set lmargin 8',
          'set size square',
          'set view map',
          'set terminal pngcairo size 640, 640',
          'unset key',
          "load 'viridis.pal'",
          "set output '#{filename.gsub('txt', 'png')}'",
          "plot '#{filename}' u ($1-128):($2-128):($3) matrix with image"
        ]
      end
    end
  end
end
