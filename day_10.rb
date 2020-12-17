module Day10
  def self.solve_part_1
    bag_of_adapters = BagOfAdapters.from_input
    bag_of_adapters.one_volt_differences * bag_of_adapters.three_volt_differences
  end

  class BagOfAdapters
    def self.from_input
      adapters = []
      process_input(10) do |line|
        adapters << line.to_i
      end
      BagOfAdapters.new(adapters.sort)
    end

    attr_reader :adapters

    def initialize(adapters)
      @adapters = adapters
    end

    def one_volt_differences
      chain_of_all_adapters.differences[1]
    end

    def three_volt_differences
      chain_of_all_adapters.differences[3] + 1
    end

    def chain_of_all_adapters
      @chain_of_all_adapters ||= AdapterChain.new(adapters).link_adapters
    end
  end

  class AdapterChain
    attr_reader :available_adapters, :chain, :rating, :differences

    def initialize(available_adapters, chain: [], rating: 0, differences: { 1 => 0, 2 => 0, 3 => 0})
      @available_adapters = available_adapters
      @chain = chain
      @rating = rating
      @differences = differences
    end

    def link_adapters
      return self if available_adapters.empty?

      possible_links = available_adapters.select { |adapter| rating + 1 == adapter || rating + 2 == adapter || rating + 3 == adapter }
      possible_links.each do |link|
        chain_from_this_adapter = AdapterChain.new(available_adapters - [link], chain: chain + [link], rating: link).link_adapters
        next unless chain_from_this_adapter

        differences = chain_from_this_adapter.differences
        differences[link - rating] += 1
        return chain_from_this_adapter
      end

      nil
    end
  end
end
