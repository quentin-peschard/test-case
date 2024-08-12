class Validators
  class OptionValidator
    def initialize(option)
      @option = option
    end

    def call
      validate_type
    end

    def validate_type
      return if %w[gps baby_seat additional_insurance].include?(@option.type)

      raise ArgumentError, 'option type must be valid'
    end
  end
end
