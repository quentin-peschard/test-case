require_relative '../../lib/rental'

describe Rental do
  describe '#validations' do
    it 'raises an ArgumentError when dates are not valid dates' do
      params = { 'id' => 1, 'start_date' => '2018-12-21', 'end_date' => '2018-12-19', 'distance' => 120 }

      expect { Rental.new(params) }.to raise_error(ArgumentError, 'start_date must be before or equal to end_date')
    end

    it 'raises an ArgumentError when distance is not a valid integer' do
      params = { 'id' => 1, 'start_date' => '2018-12-21', 'end_date' => '2018-12-25', 'distance' => -10 }

      expect { Rental.new(params) }.to raise_error(ArgumentError, 'distance is not a valid integer')
    end
  end
end
