module Day7

  def self.solve_part_1
    all_rules = Rule.from_input

    containers = []
    search_bags = ['shiny gold']
    searched = []
    loop do
      new_containers = search_bags.flat_map { |search| all_rules.select { |rule| rule.contents.any? { |content| content.colour == search } } }
      containers += new_containers
      searched += search_bags
      search_bags = new_containers.map(&:container) - searched

      break if search_bags.empty?
    end

    containers.map(&:container).uniq.size
  end

  def self.solve_part_2
  end

  class Rule
    def self.from_input
      rules = []

      process_input(7) do |line|
        rules << extract(line)
      end

      rules
    end

    def self.extract(line)
      container, contents = line.split('contain')

      container = container.strip
        .sub(' bags', '')
        .sub(' bag', '')
      contents = contents.split(',')
        .map(&:strip)
        .map { |x| x.sub('.', '') }
        .reject { |x| x == 'no other bags' }
        .map { |x| x.sub(' bags', '') }
        .map { |x| x.sub(' bag', '') }
        .map do |x|
          matches = x.match(/(\d+) (.+)/)
          RuleItem.new(matches[1], matches[2])
        end

      Rule.new(container, contents)
    end

    attr_reader :container, :contents

    def initialize(container, contents)
      @container = container
      @contents = contents
    end
  end

  class RuleItem
    attr_reader :amount, :colour

    def initialize(amount, colour)
      @amount = amount
      @colour = colour
    end
  end

end
