require 'date'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(params)
    @id = params['id']
    @car_id = params['car_id']
    @start_date = Date.parse(params['start_date'])
    @end_date = Date.parse(params['end_date'])
    @distance = params['distance']

    validate
  end

  def duration
    (end_date - start_date).to_i + 1
  end

  def get_rental_price(car)
    distance_based_price = car.price_per_km * distance
    duration_based_price = car.price_per_day * duration
    distance_based_price + duration_based_price
  end

  def validate
    validate_dates
    validate_distance
  end

  def validate_dates
    return if start_date < end_date

    raise ArgumentError, 'start_date must be before end_date'
  end

  def validate_distance
    return if distance.is_a?(Integer) && distance.positive?

    raise ArgumentError, 'distance is not a valid integer'
  end
end
