require 'set'
require_relative '../helpers/input'

class Group
  attr_reader :group_input

  def self.from_input
    groups = []
    current_group_input = []

    process_input do |line|
      if line == ''
        groups << Group.new(current_group_input)
        current_group_input = []
        next
      end

      current_group_input << line
    end

    groups << Group.new(current_group_input)

    groups
  end

  def initialize(group_input)
    @group_input = group_input
  end

  def anyone
    unique_yes_answers
  end

  def everyone
    combined_input = group_input.reduce(:+).chars
    target_count = group_input.size
    unique_yes_answers.select do |answer|
      combined_input.count { |char| char == answer } == target_count
    end
  end

  def unique_yes_answers
    Set.new(group_input.reduce(:+).chars)
  end
end
