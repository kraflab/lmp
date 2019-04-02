module LMP
  module Analysis
    class Base
      def run(demo)
        demo.frames.each do |frame|
          analyze_frame(frame)
        end
      end

      def report(filename_root)
        filename = filename_root + self.class::ANALYSIS_NAME + '.txt'
        file = File.open(filename, 'w')
        puts "Writing analysis to #{filename}"
        report_to(file)
      end
    end
  end
end
