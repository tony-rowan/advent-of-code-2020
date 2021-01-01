class Day16
  attr_reader :rules, :my_ticket, :nearby_tickets

  def initialize(input_lines)
    @rules = []
    @my_ticket = nil
    @nearby_tickets = []

    mode = :rules

    input_lines.each do |input_line|
      next if input_line.empty?

      if input_line == 'your ticket:'
        mode = :my_ticket
        next
      end

      if input_line == 'nearby tickets:'
        mode = :nearby_tickets
        next
      end

      if mode == :rules
        @rules << input_line
          .split(': ')[1]
          .split(' or ')
          .map { |range| range.split('-').map(&:to_i) }
          .map { |range| Range.new(range[0], range[1]) }
        next
      end

      if mode == :rules
        @my_ticket = Ticket.new(input_line)
        next
      end

      if mode == :nearby_tickets
        @nearby_tickets << Ticket.new(input_line)
        next
      end
    end
  end

  def solve_part_1
    ticket_scanning_error_rate
  end

  def ticket_scanning_error_rate
    invalid_values.sum
  end

  def invalid_values
    nearby_tickets.flat_map { |ticket| ticket.invalid_values(rules) }
  end

  class Ticket
    attr_reader :values

    def initialize(input_line)
      @values = input_line.split(',').map(&:to_i)
    end

    def invalid_values(rules)
      values.reject do |value|
        rules.any? do |rule|
          rule.any? do |range|
            range.include?(value)
          end
        end
      end
    end
  end
end
