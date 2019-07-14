# frozen_string_literal: true

module AnimalKindValidators
  class CatValidator < ApplicationValidator
    def validate(record)
      if record.cat? && record.owner.first_name[0] == "A"
        record.errors.add(:owner, "person's first name begins with letter A")
      end
    end
  end
end
