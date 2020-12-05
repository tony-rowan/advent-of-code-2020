require_relative './seat'

seat_ids = Seat.from_input.map(&:seat_id).sort
range = Range.new(seat_ids.first, seat_ids.last).to_a
p range - seat_ids
