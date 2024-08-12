class CarValidator
  def initialize(car)
    @car = car
  end

  def call
    validate_price_per_day
    validate_price_per_km
  end

  def validate_price_per_day
    return if valid_integer?(@car.price_per_day)

    raise ArgumentError, 'price_per_day is not a valid integer'
  end

  def validate_price_per_km
    return if valid_integer?(@car.price_per_km)

    raise ArgumentError, 'price_per_km is not a valid integer'
  end

  def valid_integer?(value)
    value.is_a?(Integer) && value.positive?
  end
end