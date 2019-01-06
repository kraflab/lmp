module LMP
  module Presenter
    extend self

    def call(demo, options)
      puts "File: #{demo.filename}"
      demo.details if options.print_details?
      demo.statistics if options.print_statistics?
    end
  end
end
