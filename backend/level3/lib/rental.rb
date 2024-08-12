require 'date'
require_relative '../services/validators/rental_validator'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(params)
    @id = params['id']
    @car_id = params['car_id']
    @start_date = Date.parse(params['start_date'])
    @end_date = Date.parse(params['end_date'])
    @distance = params['distance']

    Validators::RentalValidator.new(self).call
  end

  def duration
    (end_date - start_date).to_i + 1
  end
end
