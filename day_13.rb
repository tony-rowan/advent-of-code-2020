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

  def self.notes
    lines = []
    process_input(13) { |line| lines << line }
    estimated_departure_time, bus_ids = lines
    {
      estimated_departure_time: estimated_departure_time.to_i,
      bus_ids: bus_ids.split(',').map(&:to_i).compact.reject(&:zero?)
    }
  end
end
