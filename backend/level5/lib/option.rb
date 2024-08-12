require_relative '../services/validators/option_validator'

class Option
  attr_reader :id, :rental_id, :type

  def initialize(params)
    @id = params['id']
    @rental_id = params['rental_id']
    @type = params['type']

    Validators::OptionValidator.new(self).call
  end
end
