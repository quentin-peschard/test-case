require 'json'
require_relative '../../lib/car'
require_relative '../../lib/rental'
require_relative '../../lib/option'

class FileHandlers
  class Mapper
    def initialize(file_path)
      @file_path = file_path
    end

    def call
      file_content = read_and_parse_input_file
      extract_data(file_content)
    end

    def read_and_parse_input_file
      file = File.read(@file_path)
      JSON.parse(file)
    end

    def extract_data(file_content)
      file_content.map do |key, value|
        case key
        when 'cars' then value.map { |car| Car.new(car) }
        when 'rentals' then value.map { |rental| Rental.new(rental) }
        when 'options' then value.map { |option| Option.new(option) }
        end
      end
    end
  end
end
