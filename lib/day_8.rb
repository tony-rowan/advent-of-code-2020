module Day8
  def self.solve_part_1
    _, _, acc = Program.from_input.run_until_loop

    acc
  end

  def self.solve_part_2
    fix_attempt = 0
    acc = nil

    loop do
      puts "Attempt fix: #{fix_attempt}"
      program = Program.from_input
      program.attempt_fix(fix_attempt += 1)
      terminated, _, acc = program.run_until_loop
      break if terminated
    end

    acc
  end

  class Program
    def self.from_input
      instructions = []
      process_input(8) do |line|
        instructions << Instruction.new(instructions.size, *(line.split(" ")))
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
        return [true, step, acc] if step >= instructions.size
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

      [false, step, acc]
    end

    def attempt_fix(step)
      instructions[step].flip
    end
  end

  class Instruction
    attr_reader :line, :instruction, :argument

    def initialize(line, instruction, argument)
      @line = line
      @instruction = instruction
      @argument = argument
    end

    def flip
      ins = instruction
      @instruction = 'nop' if ins == 'jmp'
      @instruction = 'jmp' if ins == 'nop'
    end
  end
end
