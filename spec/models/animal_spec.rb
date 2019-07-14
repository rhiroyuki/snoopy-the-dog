# frozen_string_literal: true

require "rails_helper"

describe Animal do
  describe "associations" do
    subject(:animal) { build_stubbed(:animal) }

    it do
      expect(animal).to belong_to(:owner)
        .class_name("Person").with_foreign_key(:person_id)
    end
  end

  describe "validations" do
    describe "AR validations" do
      subject(:animal) { build_stubbed(:animal) }

      it do
        expect(animal).to validate_numericality_of(:monthly_fee)
          .is_greater_than_or_equal_to(0)
      end
    end

    describe "custom validations" do
      describe "swallow validation" do
        context "when person age is < 18" do
          before { freeze_time(Time.local(2018, 12, 12, 12, 12)) }
          after { unfreeze_time }

          it "is animal is invalid" do
            person = build_stubbed(:person, birthdate_on: Date.new(2002, 10, 10))
            animal = build_stubbed(:animal, owner: person, animal_kind: :swallow)

            expect(animal).to be_invalid
          end

          it "is error is about person age being < 18" do
            person = build_stubbed(:person, birthdate_on: Date.new(2002, 10, 10))
            animal = build_stubbed(:animal, owner: person, animal_kind: :swallow)

            animal.valid?

            expect(animal.errors.messages).to include(owner: ["person age must be at least 18 or higher"])
          end
        end
      end
    end
  end

  describe "enums" do
    subject(:animal) { build_stubbed(:animal) }

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
