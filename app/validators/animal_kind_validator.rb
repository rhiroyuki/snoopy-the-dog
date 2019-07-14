# frozen_string_literal: true

class AnimalKindValidator < ApplicationValidator
  def validate(record)
    validator = validator_class(record)

    if validator
      validator.new.validate(record)
    end
  end

  private

  def validator_class(record)
    "AnimalKindValidators::#{record.animal_kind.to_s.capitalize}Validator"
      .safe_constantize
  end
end
