module Day3

  def self.solve_part_1
    "lost"
  end

  def self.solve_part_2
    configurations = [
      { x: 1, y: 1 },
      { x: 3, y: 1 },
      { x: 5, y: 1 },
      { x: 7, y: 1 },
      { x: 1, y: 2 },
    ]

    trees_encountered = configurations.map do |configuration|
      x_step = configuration[:x]
      y_step = configuration[:y]

      trees_encountered_in_configuration = 0
      x_index = 0

      (y_step..(input.length - 1)).step(y_step).each do |y_index|
        row = input[y_index]
        x_index += x_step
        trees_encountered_in_configuration += 1 if row[x_index % row.length] == "#"
      end

      trees_encountered_in_configuration
    end

    trees_encountered.reduce(:*)
  end

  def self.input
    return @_input if @_input

    @_input = []
    process_input(3) do |line|
      @_input << line.to_i
    end

    @_input
  end
end
