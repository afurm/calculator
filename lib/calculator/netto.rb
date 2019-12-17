# Calculator - 2019
# frozen_string_literal: true

module Calculator
  # Netto 2019
  class Netto
    class << self
      def call(amount:, commission_total:)
        calculate(amount: amount, commission_total: commission_total)
      end

      private

      def calculate(amount:, commission_total:)
        result = amount - commission_total
        return result unless result <= 0

        raise CalculatorError,
              'Commission is higer than total Amount'
      end
    end
  end
end
