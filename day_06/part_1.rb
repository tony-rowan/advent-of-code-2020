require_relative './group'

p Group.from_input.map(&:anyone).map(&:size).reduce(:+)
