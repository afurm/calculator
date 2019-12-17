# frozen_string_literal: true

require 'calculator/version'
require 'calculator/calculator_error'
require 'calculator/netto'
require 'calculator/commision'
require 'calculator/product/basic_product'
require 'calculator/product/hardware_product'
require 'calculator/product/software_product'
require 'calculator/user/basic_user'
require 'calculator/user/individual_entrepreneur_user'
require 'calculator/user/legal_entity_user'

# Calculator 2019
module Calculator
  class << self
    def call(amount:, commission_amount: nil,
             commission_percent: Commission::DEFAULT_COMMISION_PERCENT,
             commission_entity: nil)
      commission_amount_calculated = calculte_commission_amount(amount_entity: commission_entity,
                                                                amount: commission_amount)
      commission_total = Commission
                         .call(amount: amount,
                               commission_amount: commission_amount_calculated,
                               commission_percent: commission_percent)
      net_amount = Netto.call(amount: amount,
                              commission_total: commission_total)

      [net_amount.round(2), commission_total.round(2)]
    end

    private

    def calculte_commission_amount(amount_entity:, amount:)
      return amount_entity.commission_amount if amount_entity
      return amount if amount

      Commission::DEFAULT_COMMISION
    end
  end
end
