require_relative './group'

p Group.from_input.map(&:everyone).map(&:size).reduce(:+)
