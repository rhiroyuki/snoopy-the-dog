# frozen_string_literal: true

class Animal < ApplicationRecord
  belongs_to :owner, class_name: "Person", foreign_key: :person_id

  validates :monthly_fee, numericality: {greater_than_or_equal_to: 0}

  validate :swallow_animal

  enum animal_kind: [:other,
                     :horse,
                     :dog,
                     :parrot,
                     :llama,
                     :iguana,
                     :platypus,
                     :cat,
                     :swallow,]

  def swallow_animal
    if swallow? && owner.age < 18
      errors.add(:owner, "person age must be at least 18 or higher")
    end
  end
end
