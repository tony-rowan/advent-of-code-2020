module Day2
  def self.solve_part_1
    "lost"
  end

  def self.solve_part_2
    valid = 0

    input.each do |datum|
      min_max, letter, password = datum.split(" ")
      a_index, b_index = datum.split("-").map(&:to_i).map { |x| x - 1 }
      letter = letter.chars.first
      password_letters = password.chars

      a_letter = password_letters[a_index]
      b_letter = password_letters[b_index]

      valid += 1 if (a_letter == letter) ^ (b_letter == letter)
    end

    valid
  end

  def self.input
    return @_input if @_input

    @_input = []
    process_input(2) do |line|
      @_input << line.to_i
    end

    @_input
  end
end
