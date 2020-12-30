module Day9
  def self.solve_part_1
    Stream.from_input.weakspot
  end

  def self.solve_part_2
    Stream.from_input.weakness
  end

  class Stream
    def self.from_input
      numbers = []
      process_input(9) do |line|
        numbers << line.to_i
      end

      Stream.new(numbers)
    end

    attr_reader :numbers

    def initialize(numbers)
      @numbers = numbers
    end

    def weakspot
      WeakspotFinder.new(numbers).run
    end

    def weakness
      Cracker.new(numbers, weakspot).run
    end
  end

  class WeakspotFinder
    attr_reader :numbers, :possible_numbers

    def initialize(numbers)
      @numbers = numbers
      @possible_numbers = []
    end

    def run
      numbers.each_with_index do |n, index|
        add_possible_number(n)
        next if index < 25
        next if possible_numbers.any? { |a| possible_numbers.any? { |b| n == a + b } }

        return n
      end

      nil
    end

    def add_possible_number(number)
      possible_numbers << number
      possible_numbers.drop(1) if possible_numbers.size > 25
    end
  end

  class Cracker
    attr_reader :numbers, :weakspot

    def initialize(numbers, weakspot)
      @numbers = numbers
      @weakspot = weakspot
    end

    def run
      numbers.each_with_index do |n, i|
        contiguous = [n]

        numbers.drop(i + 1).each_with_index do |m, j|
          contiguous << m
          break if contiguous.sum > weakspot
          return contiguous.min + contiguous.max if contiguous.sum == weakspot
        end
      end
    end
  end
end
