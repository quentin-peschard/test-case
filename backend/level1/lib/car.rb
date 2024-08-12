class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(params)
    @id = params['id']
    @price_per_day = params['price_per_day']
    @price_per_km = params['price_per_km']

    validate
  end

  def validate
    validate_price_per_day
    validate_price_per_km
  end

  def validate_price_per_day
    return if valid_integer?(@price_per_day)

    raise ArgumentError, 'price_per_day is not a valid integer'
  end

  def validate_price_per_km
    return if valid_integer?(@price_per_km)

    raise ArgumentError, 'price_per_km is not a valid integer'
  end

  def valid_integer?(value)
    value.is_a?(Integer) && value.positive?
  end
end
