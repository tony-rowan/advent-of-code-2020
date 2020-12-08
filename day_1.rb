module Day1
  def self.solve_part_1
    "lost"
  end

  def self.solve_part_2
    input.each_with_index do |i, i_index|
      input.each_with_index do |j, j_index|
        input.each_with_index do |k, k_index|
          next if i_index <= j_index
          next if j_index <= k_index

          return i * j * k if i + j + k == 2020
        end
      end
    end
  end

  def self.input
    return @_input if @_input

    @_input = []
    process_input(1) do |line|
      @_input << line.to_i
    end

    @_input
  end
end
