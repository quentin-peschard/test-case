require_relative '../../lib/action'
require 'json'


class Calculators
  class TransactionsCalculator
    def initialize(rental)
      @actions = []
      @rental = rental
    end

    def call
      calculate_debit
      calculate_credit
      @actions.map(&:to_hash)
    end

    private

    def calculate_debit
      @actions << Action.new({ who: 'driver', type: 'debit', amount: @rental[:price] })
    end

    def calculate_credit
      @actions << Action.new({ who: 'owner', type: 'credit', amount: (@rental[:price] - @rental[:commission].values.sum).to_i })
      @rental[:commission].each { |who, amount| @actions << Action.new({ who: who.to_s.gsub!('_fee', ''), type: 'credit', amount: amount }) }
    end
  end
end
