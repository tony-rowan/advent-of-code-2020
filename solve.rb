#!ruby

require 'awesome_print'
require 'optparse'

(1..9).each { |n| require_relative "./day_#{n}" }

def process_input(day)
  File.open("./puzzle_inputs/day_#{day}.txt").each_line(chomp: true) do |line|
    yield line
  end
end

class Options
  attr_accessor :day, :part

  def validate!
    if day.nil?
      p "You must specify a day."
      p "solve.rb --help"
      exit(1)
    end

    if part.nil?
      p "You must specify a part."
      p "solve.rb --help"
      exit(1)
    end
  end
end

class Parser
  def self.parse!
    options = Options.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: solve.rb [options]"

      opts.on("-d", "--day [DAY]", "Day to Solve") do |day|
        options.day = day
      end
      opts.on("-p", "--part [PART]", "Part to Solve") do |part|
        options.part = part
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!
    return options
  end
end

options = Parser.parse!
options.validate!

puts "--- Day: #{options.day}, Part: #{options.part} ---"
puts "Answer: #{Object.const_get("Day#{options.day}").send("solve_part_#{options.part}")}"
