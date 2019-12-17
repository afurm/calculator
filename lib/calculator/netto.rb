module Calculator
  class Netto
    class << self
      def call(amount:, commission_total:)
        calculate(amount: amount, commission_total: commission_total)
      end

      private
      def calculate(amount:, commission_total:)
        result = amount - commission_total
        raise CalculatorError.new 'Commission is higer than total Amount' if result <= 0
        result
      end
    end
  end
end
