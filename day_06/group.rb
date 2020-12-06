require 'set'
require_relative '../helpers/input'

class Group
  attr_reader :answers

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
    @answers = Set.new(group_input.reduce(:+).chars)
  end
end
