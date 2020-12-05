require_relative './seat'

seats = []

File.open(ARGV[0]).each_line(chomp: true) do |line|
  seats << Seat.new(line)
end

seat_ids = seats.map(&:seat_id).sort
range = Range.new(seat_ids.first, seat_ids.last).to_a
p range - seat_ids
