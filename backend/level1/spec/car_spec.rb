require_relative '../lib/car'

describe Car do
  describe '#validate' do
    it 'raises an ArgumentError when price_per_day is not a valid integer' do
      params = { 'id' => 1, 'price_per_day' => 0, 'price_per_km' => 5 }

      expect { Car.new(params) }.to raise_error(ArgumentError, 'price_per_day is not a valid integer')
    end

    it 'raises an ArgumentError when price_per_km is not a valid integer' do
      params = { 'id' => 1, 'price_per_day' => 10, 'price_per_km' => -20 }

      expect { Car.new(params) }.to raise_error(ArgumentError, 'price_per_km is not a valid integer')
    end
  end
end
