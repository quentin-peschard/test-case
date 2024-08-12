class Calculators
  class RentalCalculator
    def initialize(car, rental)
      @car = car
      @rental = rental
    end

    def call
      calculate_rental_price
    end

    private

    def calculate_rental_price
      distance_based_price = @car.price_per_km * @rental.distance
      time_based_price = calculate_time_based_price

      distance_based_price + time_based_price
    end

    def calculate_time_based_price
      total_price = 0

      (1..@rental.duration).each do |day|
        total_price += case day
                       when 0..1 then @car.price_per_day
                       when 2..4 then @car.price_per_day * 0.9
                       when 5..10 then @car.price_per_day * 0.7
                       when 11.. then @car.price_per_day * 0.5
                       end
      end

      total_price.to_i
    end
  end
end
