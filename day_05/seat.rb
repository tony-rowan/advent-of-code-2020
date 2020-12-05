require_relative '../helpers/input'

class Seat
  attr_reader :boarding_pass

  def self.from_input
    seats = []

    process_input do |line|
      seats << Seat.new(line)
    end

    seats
  end

  def initialize(boarding_pass)
    @boarding_pass = boarding_pass
  end

  def seat_id
    row * 8 + column
  end

  def row
    search_min = 0
    search_max = 127

    boarding_pass_row_part.chars.each do |char|
      search_min += median(search_min, search_max) if char == 'B'
      search_max -= median(search_min, search_max) if char == 'F'
    end

    mean(search_min, search_max)
  end

  def column
    search_min = 0
    search_max = 7

    boarding_pass_column_part.chars.each do |char|
      search_min += median(search_min, search_max) if char == 'R'
      search_max -= median(search_min, search_max) if char == 'L'
    end

    mean(search_min, search_max)
  end

  def median(min, max)
    (max - min + 1) / 2
  end

  def mean(a, b)
    (a + b + 1) / 2
  end

  def boarding_pass_row_part
    boarding_pass_parts[1]
  end

  def boarding_pass_column_part
    boarding_pass_parts[2]
  end

  def boarding_pass_parts
    @_boarding_pass_parts ||= boarding_pass.match(/^([FB]{7})([RL]{3})$/)
  end
end
