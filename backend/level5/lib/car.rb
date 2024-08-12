require_relative '../services/validators/car_validator'

class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(params)
    @id = params['id']
    @price_per_day = params['price_per_day']
    @price_per_km = params['price_per_km']

    Validators::CarValidator.new(self).call
  end
end
