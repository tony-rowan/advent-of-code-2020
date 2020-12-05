require_relative './seat'

seats = []

File.open(ARGV[0]).each_line(chomp: true) do |line|
  seats << Seat.new(line)
end

p seats.map(&:seat_id).max
