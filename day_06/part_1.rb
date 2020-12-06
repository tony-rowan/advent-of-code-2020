require_relative './group'

p Group.from_input.map(&:answers).map(&:size).reduce(:+)
