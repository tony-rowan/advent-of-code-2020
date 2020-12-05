def process_input
  File.open(ARGV[0]).each_line(chomp: true) do |line|
    yield line
  end
end
