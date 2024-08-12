

class Validators
  class ActionValidator
    def initialize(action)
      @action = action
    end

    def call
      validate_type
      validate_amount
    end

    def validate_type
      return if %w[debit credit].include?(@action.type)

      raise ArgumentError, 'action type must be either debit or credit'
    end

    def validate_amount
      return if valid_integer?(@action.amount)

      raise ArgumentError, 'amount is not a valid integer'
    end

    def valid_integer?(value)
      value.is_a?(Integer) && value.positive?
    end
  end
end
