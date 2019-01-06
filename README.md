# LMP Demo Format Analyzer

This is a small tool for analyzing `.lmp` demo files, which are produced by the classic 90s fps Doom and its offspring source ports. The analyzer can handle vanilla **doom**, **boom**, and **mbf** formats currently.

Run the analyzer with `ruby parse_lmp.rb --help` for basic usage instructions.

It can print out info from the header (e.g., compatibility settings, demo seed, or command line options), as well as basic statistics. These include straferun and turning frequencies, as well as a handful of simple flags.

In the future, this could provide some heuristics for detecting cheating, although such things are difficult to be certain about. Right now it detects turbo and sr50 on turns, which are definitive measures.
