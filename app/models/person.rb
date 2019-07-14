# frozen_string_literal: true

class Person < ApplicationRecord
  MONTHLY_FEE_SUM_LIMIT = 1000.00

  has_many :animals

  def age
    ((Time.zone.now - birthdate_on.to_time) / 1.year.seconds).floor
  end
end
