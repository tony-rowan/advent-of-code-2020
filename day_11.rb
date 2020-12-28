module Day11
  def self.solve_part_1
    seating_arrangement = SeatingArrangement.from_input
    seating_arrangement.stabilize
    seating_arrangement.occupied_seats
  end

  class SeatingArrangement
    EMPTY_SEAT = 'L'.freeze
    OCCUPIED_SEAT = '#'.freeze
    FLOOR = '.'.freeze

    def self.from_input
      lines = []
      process_input(11) { |line| lines << line.chars }
      new(lines)
    end

    attr_reader :rows_of_seats

    def initialize(rows_of_seats)
      @rows_of_seats = rows_of_seats
    end

    def occupied_seats
      seats.count { |s| s == OCCUPIED_SEAT }
    end

    def empty_seats
      seats.count { |s| s == EMPTY_SEAT }
    end

    def floor
      seats.count { |s| s == FLOOR }
    end

    def seats
      rows_of_seats.flatten
    end

    def stabilize
      loop do
        new_rows_of_seats = _apply_rules
        break if new_rows_of_seats == rows_of_seats

        @rows_of_seats = new_rows_of_seats
      end
    end

    def _apply_rules
      rows_of_seats.each_with_index.map do |row_of_seats, row_index|
        row_of_seats.each_with_index.map do |seat, seat_index|
          _apply_change_to_seat(seat, _adjacent_seats(row_index, seat_index))
        end
      end
    end

    def _apply_change_to_seat(seat, adjacent_seats)
      return _apply_change_to_empty_seat(seat, adjacent_seats) if seat == EMPTY_SEAT
      return _apply_change_to_occupied_seat(seat, adjacent_seats) if seat == OCCUPIED_SEAT

      seat
    end

    def _apply_change_to_empty_seat(seat, adjacent_seats)
      return OCCUPIED_SEAT if adjacent_seats.none? { |s| s == OCCUPIED_SEAT }

      seat
    end

    def _apply_change_to_occupied_seat(seat, adjacent_seats)
      return EMPTY_SEAT if adjacent_seats.count { |s| s == OCCUPIED_SEAT } >= 4

      seat
    end

    def _adjacent_seats(row, seat)
      adjacent_seats = []
      adjacent_seats << rows_of_seats.dig(row - 1, seat - 1) if row > 0 && seat > 0
      adjacent_seats << rows_of_seats.dig(row - 1, seat) if row > 0
      adjacent_seats << rows_of_seats.dig(row - 1, seat + 1) if row > 0
      adjacent_seats << rows_of_seats.dig(row, seat - 1) if seat > 0
      adjacent_seats << rows_of_seats.dig(row, seat + 1)
      adjacent_seats << rows_of_seats.dig(row + 1, seat - 1) if seat > 0
      adjacent_seats << rows_of_seats.dig(row + 1, seat)
      adjacent_seats << rows_of_seats.dig(row + 1, seat + 1)
      adjacent_seats.compact
    end
  end
end
