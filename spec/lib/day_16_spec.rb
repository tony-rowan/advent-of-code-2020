require 'lib_helper'

RSpec.describe Day16 do
  describe '#solve_part_1' do
    it 'solves the example correctly' do
      input = File.readlines('./spec/data/day_16_part_1_input.txt', chomp: true)
      expect(Day16.new(input).solve_part_1).to eq(71)
    end
  end
end
