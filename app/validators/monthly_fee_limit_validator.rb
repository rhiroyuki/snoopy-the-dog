# frozen_string_literal: true

class MonthlyFeeLimitValidator < ApplicationValidator
  def validate(record)
    return true unless record.owner

    if (record.owner.animals.pluck(:monthly_fee).sum + record.monthly_fee) > Person::MONTHLY_FEE_SUM_LIMIT
      record.errors.add(:animals, "monthly fee surpassed limit")
    end
  end
end
