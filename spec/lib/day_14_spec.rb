require 'lib_helper'

RSpec.describe Day14 do
  describe '#solve_part_1' do
    it 'solves the example correctly' do
      expect(Day14.new(input).solve_part_1).to eq(165)
    end
  end

  private

  def input
    File.readlines('./spec/data/day_14_input.txt', chomp: true)
  end
end
