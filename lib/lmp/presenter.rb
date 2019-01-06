module LMP
  module Presenter
    extend self

    def call(demo, options)
      return demo.dump_frames if options.dump_frames?

      puts "File: #{demo.filename}"
      demo.details if options.print_details?
      demo.statistics if options.print_statistics?
    end
  end
end
