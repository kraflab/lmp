# LMP Demo Format Analyzer

This is a small tool for analyzing `.lmp` demo files, which are produced by the classic 90s fps Doom and its offspring source ports. The analyzer can handle vanilla **doom**, **boom**, and **mbf** formats currently.

Support for heretic is available but experimental. You need to manually set the format with `--engine=heretic` since heretic predates versioned lmp formats.

Run the analyzer with `ruby parse_lmp.rb -h` for basic usage instructions.

It can print out info from the header (e.g., compatibility settings, demo seed, or command line options), as well as basic statistics. These include straferun and turning frequencies, as well as a handful of flags and counters.

Run the analyzer with `ruby parse_lmp.rb -x` for an explanation of the statistics.
