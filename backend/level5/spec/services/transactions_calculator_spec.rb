require_relative '../../lib/car'
require_relative '../../lib/rental'
require_relative '../../lib/option'
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

  it 'returns the correct transaction when options are added' do
    rental = { id: 1, price: 3000, commission: { insurance_fee: 450, assistance_fee: 100, drivy_fee: 350 } }
    option_1 = Option.new({ 'id' => 1, 'rental_id' => 1, 'type' => 'gps' })
    option_2 = Option.new({ 'id' => 2, 'rental_id' => 1, 'type' => 'baby_seat' })
    options = [option_1, option_2]
    output = [
      {
        who: 'driver',
        type: 'debit',
        amount: 5800
      },
      {
        who: 'owner',
        type: 'credit',
        amount: 4900
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

    expect(Calculators::TransactionsCalculator.new(rental, 4, options).call).to eq(output)
  end
end
