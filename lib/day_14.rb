class Day14
  attr_reader :instructions

  def initialize(input_lines)
    instructions = []
    input_lines.each { |line| instructions << Instruction.from_input_line(line) }
    @instructions = instructions
  end

  def solve_part_1
    program = DockingProgram.new(instructions)
    program.execute
    program.memory.values.map(&:to_i).sum
  end

  def solve_part_2
    program = DockingProgramVersion2.new(instructions)
    program.execute
    program.memory.values.map(&:to_i).sum
  end

  class DockingProgram
    attr_reader :mask, :memory, :instructions

    def initialize(instructions)
      @memory = {}
      @mask = nil
      @instructions = instructions
    end

    def execute
      instructions.each do |instruction|
        case instruction
        in SetMaskInstruction[new_mask]
          @mask = new_mask
        in WriteMemoryInstruction[address, value]
          memory[address] = _apply_mask(value)
        else
          raise "Could not perform instruction: #{instruction.raw}"
        end
      end
    end

    def _apply_mask(value)
      binary_value = value.to_i.to_s(2)
      padded_binary_value = '0' * (36 - binary_value.size) + binary_value
      mask.chars.each_with_index do |mask_char, index|
        next if mask_char == 'X'

        padded_binary_value[index] = mask_char
      end
      padded_binary_value.to_i(2)
    end
  end

  class DockingProgramVersion2
    attr_reader :mask, :memory, :instructions

    def initialize(instructions)
      @memory = {}
      @mask = nil
      @instructions = instructions
    end

    def execute
      instructions.each do |instruction|
        case instruction
        in SetMaskInstruction[new_mask]
          @mask = new_mask
        in WriteMemoryInstruction[address, value]
          _apply_mask(address).each do |address|
            memory[address] = value
          end
        else
          raise "Could not perform instruction: #{instruction.raw}"
        end
      end
    end

    def _apply_mask(address)
      binary_address = address.to_i.to_s(2)
      padded_binary_address = '0' * (36 - binary_address.size) + binary_address

      addresses = [padded_binary_address]

      36.times do |i|
        addresses = addresses.flat_map do |a|
          case mask[i]
          when 'X'
            a = a.dup
            b = a.dup
            a[i] = '1'
            b[i] = '0'
            [a, b]
          when '1'
            a = a.dup
            a[i] = '1'
            a
          else
            a
          end
        end
      end

      addresses
    end
  end

  class Instruction
    def self.from_input_line(input_line)
      if (match_data = /^mask = (.+)$/.match(input_line))
        return SetMaskInstruction.new(match_data[1])
      end

      if (match_data = /^mem\[(\d+)\] = (.+)$/.match(input_line))
        return WriteMemoryInstruction.new(match_data[1], match_data[2])
      end

      raise "Cannot parse instruction: #{input_line}"
    end
  end

  class SetMaskInstruction
    attr_reader :mask

    def initialize(mask)
      @mask = mask
    end

    def deconstruct
      [mask]
    end

    def deconstruct_keys(_keys)
      { mask: mask }
    end
  end

  class WriteMemoryInstruction
    attr_reader :address, :value

    def initialize(address, value)
      @address = address
      @value = value
    end

    def deconstruct
      [address, value]
    end

    def deconstruct_keys(_keys)
      { address: address, value: value }
    end
  end
end
