module Day12
  def self.solve_part_1
    ship = Ship.new
    ship.navigate(instructions)
    ship.north.abs + ship.east.abs
  end

  def self.instructions
    instructions = []
    process_input(12) { |line| instructions << Instruction.new(line) }
    instructions
  end

  class Ship
    attr_reader :north, :east, :bearing

    def initialize
      @north = 0
      @east = 0
      @bearing = 0
    end

    def navigate(instructions)
      instructions.each do |instruction|
        @north += _north_delta(instruction)
        @east += _east_delta(instruction)
        @bearing += _bearing_delta(instruction)
        @bearing %= 360
      end
    end

    def _north_delta(instruction)
      return instruction.value if instruction.command == 'N'
      return -instruction.value if instruction.command == 'S'

      if instruction.command == 'F'
        return instruction.value if bearing == 270
        return -instruction.value if bearing == 90
      end

      0
    end

    def _east_delta(instruction)
      return instruction.value if instruction.command == 'E'
      return -instruction.value if instruction.command == 'W'

      if instruction.command == 'F'
        return instruction.value if bearing == 0
        return -instruction.value if bearing == 180
      end

      0
    end

    def _bearing_delta(instruction)
      return instruction.value if instruction.command == 'R'
      return -instruction.value if instruction.command == 'L'

      0
    end
  end

  class Instruction
    attr_reader :raw, :command, :value

    def initialize(raw)
      @raw = raw
      @command = raw.chars.first
      @value = raw.chars[1..-1].join('').to_i
    end
  end
end
