# frozen_string_literal: true

module User
  # IndividualEntrepreneurUser - 2019
  class IndividualEntrepreneurUser < BasicUser
    def commission_amount
      0.33
    end
  end
end
