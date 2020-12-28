module Day11
  def self.solve_part_1
    seating_arrangement = SeatingArrangement.from_input
    seating_arrangement.stabilize
    seating_arrangement.occupied_seats
  end

  def self.solve_part_2
    seating_arrangement = SeatingArrangement.from_input(seat_selector: :visible, tolerance: 5)
    seating_arrangement.stabilize
    seating_arrangement.occupied_seats
  end

  class SeatingArrangement
    EMPTY_SEAT = 'L'.freeze
    OCCUPIED_SEAT = '#'.freeze
    FLOOR = '.'.freeze

    def self.from_input(seat_selector: :adjacent, tolerance: 4)
      lines = []
      process_input(11) { |line| lines << line.chars }
      new(lines, seat_selector, tolerance)
    end

    attr_reader :rows_of_seats, :seat_selector, :tolerance

    def initialize(rows_of_seats, seat_selector, tolerance)
      @rows_of_seats = rows_of_seats
      @seat_selector = seat_selector == :adjacent ? :_adjacent_seats : :_visible_seats
      @tolerance = tolerance
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

        p [floor, occupied_seats + empty_seats, occupied_seats]

        @rows_of_seats = new_rows_of_seats
      end
    end

    def _apply_rules
      rows_of_seats.each_with_index.map do |row_of_seats, row_index|
        row_of_seats.each_with_index.map do |seat, seat_index|
          _apply_change_to_seat(seat, send(seat_selector, row_index, seat_index))
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
      return EMPTY_SEAT if adjacent_seats.count { |s| s == OCCUPIED_SEAT } >= tolerance

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

    def _visible_seats(row, seat)
      visible_seats = []
      visible_seats << _find_seat_in_direction(row, seat, -1, -1)
      visible_seats << _find_seat_in_direction(row, seat, -1,  0)
      visible_seats << _find_seat_in_direction(row, seat, -1, +1)
      visible_seats << _find_seat_in_direction(row, seat,  0, -1)
      visible_seats << _find_seat_in_direction(row, seat,  0, +1)
      visible_seats << _find_seat_in_direction(row, seat, +1, -1)
      visible_seats << _find_seat_in_direction(row, seat, +1,  0)
      visible_seats << _find_seat_in_direction(row, seat, +1, +1)
      visible_seats.compact
    end

    def _find_seat_in_direction(row, seat, gradient_row, gradient_seat)
      row += gradient_row
      seat += gradient_seat

      return nil if row < 0 || seat < 0
      return nil if row >= rows_of_seats.count || seat >= rows_of_seats.first.count

      found_seat = rows_of_seats[row][seat]
      return found_seat unless found_seat == FLOOR

      _find_seat_in_direction(row, seat, gradient_row, gradient_seat)
    end
  end
end
