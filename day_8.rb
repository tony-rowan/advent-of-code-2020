module Day8
  def self.solve_part_1
    step, acc = Program.from_input.run_until_loop

    acc
  end

  class Program
    def self.from_input
      instructions = []
      process_input(8) do |line|
        instructions << Instruction.new(*(line.split(" ")))
      end

      Program.new(instructions)
    end

    attr_reader :instructions

    def initialize(instructions)
      @instructions = instructions
    end

    def run_until_loop
      acc = 0
      visited_steps = []
      step = 0

      loop do
        break if visited_steps.include?(step)

        visited_steps << step

        instruction = instructions[step]

        if instruction.instruction == 'nop'
          step += 1
          next
        end

        if instruction.instruction == 'acc'
          acc += instruction.argument.to_i
          step += 1
          next
        end

        if instruction.instruction == 'jmp'
          step += instruction.argument.to_i
        end
      end

      [step, acc]
    end
  end

  class Instruction
    attr_reader :instruction, :argument

    def initialize(instruction, argument)
      @instruction = instruction
      @argument = argument
    end
  end
end
