# frozen_string_literal: true

module AnimalKindValidators
  class SwallowValidator < ApplicationValidator
    MINIMUM_AGE = 18

    def validate(record)
      if record.swallow? && record.owner.age < MINIMUM_AGE
        record.errors.add(:owner, "person age must be at least 18 or higher")
      end
    end
  end
end
