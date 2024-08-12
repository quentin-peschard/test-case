require 'json'
require_relative '../../lib/car'
require_relative '../../lib/rental'

class FileHandlers
  class Writer
    def initialize(price_per_rental)
      @price_per_rental = price_per_rental
    end

    def call
      create_output_file
    end

    def create_output_file
      File.open('data/output.json', 'w') do |file|
        file.write(JSON.pretty_generate(rentals: @price_per_rental))
      end
    end
  end
end
