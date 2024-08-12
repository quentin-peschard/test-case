require_relative '../../lib/car'
require_relative '../../lib/rental'
require_relative '../../services/calculators/rental_calculator'

describe Calculators::RentalCalculator do
  describe '#call' do
    it 'returns the correct rental price' do
      car = Car.new({ 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 })
      rental = Rental.new({ 'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-8', 'end_date' => '2015-12-10', 'distance' => 100 })

      expect(Calculators::RentalCalculator.new(car, rental).call).to eq(6600)
    end

    it 'decreases the price per day after 4 days' do
      car = Car.new({ 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 })
      rental = Rental.new({ 'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-8', 'end_date' => '2015-12-13', 'distance' => 250 })

      expect(Calculators::RentalCalculator.new(car, rental).call).to eq(12_700)
    end
  end
end
