class Validators
  class RentalValidator
    def initialize(rental)
      @rental = rental
    end

    def call
      validate_dates
      validate_distance
    end

    def validate_dates
      return if @rental.start_date <= @rental.end_date

      raise ArgumentError, 'start_date must be before or equal to end_date'
    end

    def validate_distance
      return if @rental.distance.is_a?(Integer) && @rental.distance.positive?

      raise ArgumentError, 'distance is not a valid integer'
    end
  end
end
