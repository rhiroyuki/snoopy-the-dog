# frozen_string_literal: true

require "rails_helper"

describe Animal do
  subject(:animal) { build_stubbed(:animal) }

  describe "associations" do
    it do
      expect(animal).to belong_to(:owner)
        .class_name("Person").with_foreign_key(:person_id)
    end
  end

  describe "validations" do
    it do
      expect(animal).to validate_numericality_of(:monthly_fee)
        .is_greater_than_or_equal_to(0)
    end
  end

  describe "enums" do
    it do
      animal_kinds = [
        :other,
        :horse,
        :dog,
        :parrot,
        :llama,
        :iguana,
        :platypus,
        :cat,
        :swallow,
      ]

      expect(animal).to define_enum_for(:animal_kind)
        .with_values(animal_kinds)
    end
  end
end
