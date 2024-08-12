require_relative '../../lib/car'
require_relative '../../lib/rental'
require_relative '../../services/calculators/transactions_calculator'

describe Calculators::TransactionsCalculator do
  describe '#call' do
    it 'returns the correct transaction' do
      rental = { id: 1, price: 3000, commission: { insurance_fee: 450, assistance_fee: 100, drivy_fee: 350 } }
      output = [
        {
          who: 'driver',
          type: 'debit',
          amount: 3000
        },
        {
          who: 'owner',
          type: 'credit',
          amount: 2100
        },
        {
          who: 'insurance',
          type: 'credit',
          amount: 450
        },
        {
          who: 'assistance',
          type: 'credit',
          amount: 100
        },
        {
          who: 'drivy',
          type: 'credit',
          amount: 350
        }
      ]

      expect(Calculators::TransactionsCalculator.new(rental).call).to eq(output)
    end
  end
end
