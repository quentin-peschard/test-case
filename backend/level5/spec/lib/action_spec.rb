require_relative '../../lib/action'

describe Action do
  describe '#validations' do
    it 'raises an ArgumentError when type is not valid' do
      params = { who: 'owner', type: 'transfer', amount: 5 }

      expect { Action.new(params) }.to raise_error(ArgumentError, 'action type must be either debit or credit')
    end

    it 'raises an ArgumentError when amount is not a valid integer' do
      params = { who: 'owner', type: 'credit', amount: -20 }

      expect { Action.new(params) }.to raise_error(ArgumentError, 'amount is not a valid integer')
    end
  end
end
