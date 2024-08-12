require_relative '../services/validators/action_validator'

class Action
  attr_accessor :who, :type, :amount

  def initialize(params)
    @who = params[:who]
    @type = params[:type]
    @amount = params[:amount]

    Validators::ActionValidator.new(self).call
  end

  def to_hash
    { who: @who, type: @type, amount: @amount }
  end
end
