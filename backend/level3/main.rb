require 'json'
require_relative 'lib/car'
require_relative 'lib/rental'
require_relative 'services/calculators/rental_calculator'
require_relative 'services/calculators/commission_calculator'
require_relative 'services/file_handlers/mapper'
require_relative 'services/file_handlers/writer'

def run_level3
  cars, rentals = FileHandlers::Mapper.new('data/input.json').call
  price_per_rental = get_price_per_rental(cars, rentals)

  FileHandlers::Writer.new(price_per_rental).call
end

def get_price_per_rental(cars, rentals)
  rentals.map do |rental|
    car = cars.find { |c| c.id == rental.car_id }
    price = Calculators::RentalCalculator.new(car, rental).call
    commission = Calculators::CommissionCalculator.new(rental.duration, price).call

    Hash[id: rental.id, price: price, commission: commission]
  end
end


run_level3
