module Day4

  def self.solve_part_1
    "lost"
  end

  def self.solve_part_2
    passports.select(&:valid?).size
  end

  class Passport
    def self.from_input
      passports = []

      current_passport = Passport.new

      process_input(4) do |line|
        if line == ''
          passports << current_passport
          current_passport = Passport.new
        end

        fields = line.split(' ')
        fields.each do |field|
          key, value = field.split(':')
          current_passport.send("#{key}=".to_sym, value)
        end

        passports << current_passport

        passports
      end
    end

    attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    def valid?
      return unless byr_valid?
      return unless iyr_valid?
      return unless eyr_valid?
      return unless hgt_valid?
      return unless hcl_valid?
      return unless ecl_valid?
      return unless pid_valid?

      true
    end

    def byr_valid?
      return if byr.nil?
      return if byr.size != 4

      byr.to_i >= 1920 && byr.to_i <= 2002
    end

    def iyr_valid?
      return if iyr.nil?
      return if iyr.size != 4

      iyr.to_i >= 2010 && iyr.to_i <= 2020
    end

    def eyr_valid?
      return if eyr.nil?
      return if eyr.size != 4

      eyr.to_i >= 2020 && eyr.to_i <= 2030
    end

    def hgt_valid?
      return if hgt.nil?

      matches = hgt.match(/(\d{2,3})(\w{2})/)

      return if matches.nil?

      amount = matches[1].to_i
      unit = matches[2]

      return amount >= 150 && amount <= 193 if unit == 'cm'
      return amount >= 59 && amount <= 76 if unit == 'in'
    end

    def hcl_valid?
      return if hcl.nil?

      hcl =~ /^#[0-9a-f]{6}$/
    end

    def ecl_valid?
      return if ecl.nil?

      %w[amb blu brn gry grn hzl oth].include?(ecl)
    end

    def pid_valid?
      return if pid.nil?

      pid =~ /^\d{9}$/
    end
  end
end
