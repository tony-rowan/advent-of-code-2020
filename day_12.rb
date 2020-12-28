module Day12
  def self.solve_part_1
    raise 'No longer implemented'
    ship = Ship.new
    ship.navigate(instructions)
    ship.north.abs + ship.east.abs
  end

  def self.solve_part_2
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
    attr_reader :north, :east, :waypoint

    def initialize
      @north = 0
      @east = 0
      @waypoint = Waypoint.new
    end

    def navigate(instructions)
      instructions.each do |instruction|
        case instruction.command
        when 'N'
          waypoint.move_north(instruction.value)
        when 'E'
          waypoint.move_east(instruction.value)
        when 'S'
          waypoint.move_south(instruction.value)
        when 'W'
          waypoint.move_west(instruction.value)
        when 'F'
          instruction.value.times { _move }
        when 'R'
          waypoint.rotate_right(instruction.value)
        when 'L'
          waypoint.rotate_left(instruction.value)
        end
      end
    end

    def _move
      @north += waypoint.north
      @east += waypoint.east
    end
  end

  class Waypoint
    attr_reader :north, :east

    def initialize(north: 1, east: 10)
      @north = north
      @east = east
    end

    def move_north(value)
      @north += value
    end

    def move_east(value)
      @east += value
    end

    def move_south(value)
      @north -= value
    end

    def move_west(value)
      @east -= value
    end

    def rotate_right(value)
      _rotate(value)
    end

    def rotate_left(value)
      _rotate(-value % 360)
    end

    def _rotate(value)
      (value / 90).times do
        @east, @north = north, -east
      end
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
