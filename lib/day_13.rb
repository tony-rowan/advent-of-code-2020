module Day13
  def self.solve_part_1
    timestep = notes[:estimated_departure_time]
    bus_ids = notes[:bus_ids]

    loop do
      bus_ids.each do |bus_id|
        if timestep % bus_id == 0
          return bus_id * (timestep - notes[:estimated_departure_time])
        end
      end

      timestep += 1
    end
  end

  def self.solve_part_2
    departure_schedule = notes[:departure_schedule]
    timestep = 0
    delta = 1

    loop do
      valid = true

      departure_schedule.each do |time, bus_id|
        if (timestep + time) % bus_id != 0
          valid = false
          break
        end

        delta = delta.lcm(bus_id)
      end

      return timestep if valid

      timestep += delta
    end
  end

  def self.notes
    lines = []
    process_input(13) { |line| lines << line }
    estimated_departure_time, bus_ids = lines
    {
      estimated_departure_time: estimated_departure_time.to_i,
      bus_ids: bus_ids.split(',').map(&:to_i).compact.reject(&:zero?),
      departure_schedule: bus_ids.split(',').each_with_index.map { |elem, idx| [elem, idx] }.reject { |elem, idx| elem == 'x' }.inject({}) { |hash, elem_idx| hash[elem_idx[1]] = elem_idx[0].to_i; hash }
    }
  end
end
