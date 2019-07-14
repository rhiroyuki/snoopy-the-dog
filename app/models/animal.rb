# frozen_string_literal: true

class Animal < ApplicationRecord
  belongs_to :owner, class_name: "Person", foreign_key: :person_id

  validates :monthly_fee, numericality: {greater_than_or_equal_to: 0}

  validates_with AnimalKindValidator

  validate :monthly_fee_sum_cannot_surpass_limit

  enum animal_kind: [:other,
                     :horse,
                     :dog,
                     :parrot,
                     :llama,
                     :iguana,
                     :platypus,
                     :cat,
                     :swallow,]

  def monthly_fee_sum_cannot_surpass_limit
    return true unless owner

    if (owner.animals.pluck(:monthly_fee).sum + monthly_fee) > Person::MONTHLY_FEE_SUM_LIMIT
      errors.add(:animals, "monthly fee surpassed limit")
    end
  end
end
