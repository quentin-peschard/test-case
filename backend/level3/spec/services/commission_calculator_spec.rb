require_relative '../../lib/car'
require_relative '../../lib/rental'
require_relative '../../services/calculators/commission_calculator'

describe Calculators::CommissionCalculator do
  describe '#call' do
    it 'returns the correct commission' do
      duration = 6
      price = 12_500

      expect(Calculators::CommissionCalculator.new(duration, price).call).to eq({ insurance_fee: 1875, assistance_fee: 600, drivy_fee: 1275 })
    end
  end
end
