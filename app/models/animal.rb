# frozen_string_literal: true

class Animal < ApplicationRecord
  belongs_to :owner, class_name: "Person", foreign_key: :person_id

  validates :monthly_fee, numericality: { greater_than_or_equal_to: 0 }

  enum animal_kind: [:other,
                     :horse,
                     :dog,
                     :parrot,
                     :llama,
                     :iguana,
                     :platypus,
                     :cat,
                     :swallow,]
end
