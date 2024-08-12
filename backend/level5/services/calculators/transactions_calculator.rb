require_relative '../../lib/action'
require_relative 'options_calculator'
require 'json'


class Calculators
  class TransactionsCalculator
    def initialize(rental, rental_duration = 0, rental_options = [])
      @actions = []
      @rental = rental
      @rental_duration = rental_duration
      @rental_options = rental_options
    end

    def call
      calculate_debit
      calculate_credit
      add_options if @rental_options.any?
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

    def add_options
      Calculators::OptionsCalculator.new(@actions, @rental_duration, @rental_options).call
    end
  end
end
