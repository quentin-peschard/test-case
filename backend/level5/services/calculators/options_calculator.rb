

class Calculators
  class OptionsCalculator
    def initialize(actions, rental_duration, options)
      @actions = actions
      @options = options
      @rental_duration = rental_duration
    end

    def call
      @options.each do |option|
        case option.type
        when 'gps' then calculate_gps_fee
        when 'baby_seat' then calculate_baby_seat_fee
        when 'additional_insurance' then calculate_additional_insurance_fee
        end
      end
    end

    private

    def calculate_gps_fee
      fee = 500 * @rental_duration
      @actions.find { |action| action.who == 'driver' }.amount += fee
      @actions.find { |action| action.who == 'owner' }.amount += fee
    end

    def calculate_baby_seat_fee
      fee = 200 * @rental_duration
      @actions.find { |action| action.who == 'driver' }.amount += fee
      @actions.find { |action| action.who == 'owner' }.amount += fee
    end

    def calculate_additional_insurance_fee
      fee = 1000 * @rental_duration
      @actions.find { |action| action.who == 'driver' }.amount += fee
      @actions.find { |action| action.who == 'drivy' }.amount += fee
    end
  end
end
