# frozen_string_literal: true

class Person < ApplicationRecord
  has_many :animals

  def age
    ((Time.zone.now - birthdate_on.to_time) / 1.year.seconds).floor
  end
end
