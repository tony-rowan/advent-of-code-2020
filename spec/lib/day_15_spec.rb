require 'lib_helper'

RSpec.describe Day15 do
  describe '#solve_part_1' do
    it 'solves the examples correctly' do
      input = ['0, 3, 6']
      expect(Day15.new(input).solve_part_1).to eq(436)
    end

    it 'solves the examples correctly' do
      input = ['1, 3, 2']
      expect(Day15.new(input).solve_part_1).to eq(1)
    end

    it 'solves the examples correctly' do
      input = ['2, 1, 3']
      expect(Day15.new(input).solve_part_1).to eq(10)
    end

    it 'solves the examples correctly' do
      input = ['1, 2, 3']
      expect(Day15.new(input).solve_part_1).to eq(27)
    end

    it 'solves the examples correctly' do
      input = ['2, 3, 1']
      expect(Day15.new(input).solve_part_1).to eq(78)
    end

    it 'solves the examples correctly' do
      input = ['3, 2, 1']
      expect(Day15.new(input).solve_part_1).to eq(438)
    end

    it 'solves the examples correctly' do
      input = ['3, 1, 2']
      expect(Day15.new(input).solve_part_1).to eq(1836)
    end
  end
end

RSpec.describe Day15::Game do
  describe '#play' do
    it 'plays a short game correctly' do
      game = Day15::Game.new([0, 3, 6], 10)
      game.play
      expect(game.last_number_said).to eq(0)
    end
  end
end
