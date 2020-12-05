require_relative './seat'

p Seat.from_input.map(&:seat_id).max
