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

  def solve_part_2
    game = Game.new(starting_numbers, 30_000_000)
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
          a, b = memory[last_number_said]
          @last_number_said = b - a
        end

        _remember(last_number_said, i)
      end
    end

    def _remember(n, turn)
      memory[n] =
        if memory[n]
          if memory[n].size == 1
            [memory[n][0], turn]
          else
            memory[n] = [memory[n][1], turn]
          end
        else
          memory[n] = [turn]
        end
    end
  end
end
