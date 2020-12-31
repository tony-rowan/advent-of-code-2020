class Day15
  attr_reader :starting_numbers

  def initialize(input_lines)
    @starting_numbers = input_lines.first.split(',').map(&:to_i)
  end

  def solve_part_1
    game = Game.new(starting_numbers, 2020)
    game.play
    game.last_number_said
  end

  class Game
    attr_reader :starting_numbers, :turns, :memory, :last_number_said

    def initialize(starting_numbers, turns)
      @starting_numbers = starting_numbers
      @turns = turns
      @memory = {}
      @last_number_said = nil
    end

    def play
      turns.times do |i|
        if starting_numbers[i]
          @last_number_said = starting_numbers[i]
        elsif memory[last_number_said].size == 1
          @last_number_said = 0
        else
          a, b = memory[last_number_said].last(2)
          @last_number_said = b - a
        end
        memory[last_number_said] = (memory[last_number_said] || []) + [i]
      end
    end
  end
end
