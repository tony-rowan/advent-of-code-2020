require 'lib_helper'

RSpec.describe Day14 do
  describe '#solve_part_1' do
    it 'solves the example correctly' do
      input = File.readlines('./spec/data/day_14_part_1_input.txt', chomp: true)
      expect(Day14.new(input).solve_part_1).to eq(165)
    end
  end

  describe '#solve_part_2' do
    it 'solves the example correctly' do
      input = File.readlines('./spec/data/day_14_part_2_input.txt', chomp: true)
      expect(Day14.new(input).solve_part_2).to eq(208)
    end
  end
end
