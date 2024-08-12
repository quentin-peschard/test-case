require_relative '../../lib/option'

describe Option do
  describe '#validations' do
    it 'raises an ArgumentError when type is not valid' do
      params = { 'id': 1, 'type': 'cleaning', 'rental_id': 5 }

      expect { Option.new(params) }.to raise_error(ArgumentError, 'option type must be valid')
    end
  end
end
