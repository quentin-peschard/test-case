require 'json'
require_relative 'lib/car'
require_relative 'lib/rental'

def run_level1
  file_content = read_and_parse_input_file('data/input.json')
  cars, rentals = extract_data(file_content)
  price_per_rental = get_price_per_rental(cars, rentals)

  create_output_file(price_per_rental)
end

def read_and_parse_input_file(file_path)
  file = File.read(file_path)
  JSON.parse(file)
end

def extract_data(file_content)
  file_content.map do |key, value|
    case key
    when 'cars' then value.map { |car| Car.new(car) }
    when 'rentals' then value.map { |rental| Rental.new(rental) }
    end
  end
end

def get_price_per_rental(cars, rentals)
  rentals.map do |rental|
    car = cars.find { |c| c.id == rental.car_id }
    price = rental.get_rental_price(car)

    Hash[id: rental.id, price: price]
  end
end

def create_output_file(price_per_rental)
  File.open('data/output.json', 'w') do |file|
    file.write(JSON.pretty_generate(rentals: price_per_rental))
  end
end

run_level1
