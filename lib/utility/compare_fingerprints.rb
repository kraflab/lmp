class DataFile
  attr_reader :name, :data

  def initialize(name)
    @data = parse_data(name)
    @name = name.gsub('fingerprints/fingerprint-', '')
  end

  def angle_between(other)
    return 0 if self == other

    Math.acos(data.sum { |k, v| v * (other.data[k] || 0) }).round(3)
  end

  private

  def parse_data(file_name)
    Hash[
      File.readlines(file_name, chomp: true)
          .map(&:split)
          .map { |k, v| [k.to_i, v.to_f] }
    ]
  end
end

files = ARGV.map { |name| DataFile.new(name) }

files.each do |file1|
  files.each do |file2|
    puts(
      file1.name + " " + file2.name + " " + file1.angle_between(file2).to_s
    )
  end
  puts ''
end
