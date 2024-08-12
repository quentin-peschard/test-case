require 'json'
require_relative 'lib/car'
require_relative 'lib/rental'
require_relative 'services/calculators/rental_calculator'
require_relative 'services/calculators/commission_calculator'
require_relative 'services/calculators/transactions_calculator'
require_relative 'services/file_handlers/mapper'
require_relative 'services/file_handlers/writer'

def run_level5
  cars, rentals, options = FileHandlers::Mapper.new('data/input.json').call
  price_per_rental = get_price_per_rental(cars, rentals)
  transactions_per_rental = get_transactions_per_rental(price_per_rental, options, rentals)

  FileHandlers::Writer.new('rentals', transactions_per_rental).call
end

def get_price_per_rental(cars, rentals)
  rentals.map do |rental|
    car = cars.find { |c| c.id == rental.car_id }
    price = Calculators::RentalCalculator.new(car, rental).call
    commission = Calculators::CommissionCalculator.new(rental.duration, price).call

    Hash[id: rental.id, price: price, commission: commission]
  end
end

def get_transactions_per_rental(price_per_rental, options, rentals)
  price_per_rental.map do |rental_price|
    rental = rentals.find { |r| r.id == rental_price[:id] }
    rental_options = options.select { |o| o.rental_id == rental_price[:id] }
    transactions = Calculators::TransactionsCalculator.new(rental_price, rental.duration, rental_options).call

    Hash[id: rental_price[:id], options: rental_options&.map(&:type), actions: transactions]
  end
end

run_level5
