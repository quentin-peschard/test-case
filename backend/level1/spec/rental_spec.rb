require_relative '../lib/rental'

describe Rental do
  describe '#validate' do
    it 'raises an ArgumentError when dates are not valid dates' do
      params = { 'id' => 1, 'start_date' => '2018-12-21', 'end_date' => '2018-12-19', 'distance' => 120 }

      expect { Rental.new(params) }.to raise_error(ArgumentError, 'start_date must be before end_date')
    end

    it 'raises an ArgumentError when distance is not a valid integer' do
      params = { 'id' => 1, 'start_date' => '2018-12-21', 'end_date' => '2018-12-25', 'distance' => -10 }

      expect { Rental.new(params) }.to raise_error(ArgumentError, 'distance is not a valid integer')
    end
  end

  describe '#get_rental_price' do
    it 'returns the correct rental price' do
      car = Car.new({ 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 })
      rental = Rental.new({ 'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-8', 'end_date' => '2015-12-10', 'distance' => 100 })

      expect(rental.get_rental_price(car)).to eq(7000)
    end
  end
end
