class Calculators
  class CommissionCalculator
    def initialize(rental_duration, rental_price)
      @commission = {}
      @rental_duration = rental_duration
      @rental_price = rental_price
      @total_commission = @rental_price * 0.3
    end

    def call
      calculate_insurance_fee
      calculate_assistance_fee
      calculate_drivy_fee
      @commission.transform_values!(&:to_i)
    end

    private

    def calculate_insurance_fee
      @commission[:insurance_fee] = (@total_commission / 2)
    end

    def calculate_assistance_fee
      @commission[:assistance_fee] = @rental_duration * 100
    end

    def calculate_drivy_fee
      @commission[:drivy_fee] = @total_commission - (@commission[:insurance_fee] + @commission[:assistance_fee])
    end
  end
end
