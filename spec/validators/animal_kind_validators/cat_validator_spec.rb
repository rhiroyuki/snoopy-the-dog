# frozen_string_literal: true

require "rails_helper"

describe AnimalKindValidators::CatValidator do
  describe ".validate" do
    it "validates owners with first_name beginning with A character" do
      person = build_stubbed(:person, first_name: "Axl")
      animal = build_stubbed(:animal, owner: person, animal_kind: :cat)

      described_class.new.validate(animal)

      expect(animal.errors.messages).to include(owner: ["person's first name begins with letter A"])
    end
  end
end
