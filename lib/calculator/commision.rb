# Calculator - 2019
# frozen_string_literal: true

module Calculator
  # Commission 2019
  class Commission
    DEFAULT_COMMISION = 1.0
    DEFAULT_COMMISION_PERCENT = 30.0

    attr_reader :user, :product

    def initialize(user:, product:)
      @user = user
      @product = product
    end

    def commission_amount
      user.commission_amount + product.commission_amount
    end

    class << self
      def call(amount:, commission_amount:, commission_percent:)
        calculate(amount: amount,
                  commission_amount: commission_amount,
                  commission_percent: commission_percent)
      end

      private

      def calculate(amount:, commission_amount:, commission_percent:)
        amount * normalize_percent(commission_percent: commission_percent) +
          calulate_commission_amount(commission_amount: commission_amount,
                                     amount: amount)
      end

      def normalize_percent(commission_percent:)
        commission_percent.to_f / 100
      end

      def calulate_commission_amount(commission_amount:, amount:)
        return commission_amount if amount <= 100

        ((amount - 100) * 0.001) + commission_amount
      end
    end
  end
end
