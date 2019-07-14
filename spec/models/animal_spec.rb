# frozen_string_literal: true

require "rails_helper"

describe Animal do
  describe "associations" do
    subject(:animal) { build(:animal) }

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
      describe "#monthly_fee_sum_cannot_surpass_limit" do
        context "when owner is not set" do
          it "makes the animal valid" do
            dog = build(:animal, owner: build(:person))

            expect(dog).to be_valid
          end
        end

        context "when animal monthly_fee surpass sum limit" do
          it "makes the animal invalid" do
            animals = [build(:animal, monthly_fee: 800.00)]
            owner = create(:person, animals: animals)

            dog = build(:animal, monthly_fee: 200.01, owner: owner)

            expect(dog).to be_invalid
          end
        end
      end

      describe "cat validation" do
        context "when person first name starts with letter A" do
          it "animal is invalid" do
            person = build_stubbed(:person, first_name: "Axl")
            animal = build_stubbed(:animal, owner: person, animal_kind: :cat)

            expect(animal).to be_invalid
          end
        end

        context "when person first name doesnt start with letter A" do
          it "animal is invalid" do
            person = build_stubbed(:person, first_name: "Exl")
            animal = build_stubbed(:animal, owner: person, animal_kind: :cat)

            expect(animal).to be_valid
          end
        end
      end

      describe "swallow validation" do
        context "when person age is 17" do
          before { freeze_time(Time.local(2018, 12, 12, 12, 12)) }
          after { unfreeze_time }

          it "animal is invalid" do
            person = build_stubbed(:person, birthdate_on: Date.new(2001, 10, 10))
            animal = build_stubbed(:animal, owner: person, animal_kind: :swallow)

            expect(animal).to be_invalid
          end
        end

        context "when person age is 18" do
          before { freeze_time(Time.local(2018, 12, 12, 12, 12)) }
          after { unfreeze_time }

          it "animal is valid" do
            person = build_stubbed(:person, birthdate_on: Date.new(2000, 10, 10))
            animal = build_stubbed(:animal, owner: person, animal_kind: :swallow)

            expect(animal).to be_valid
          end
        end

        context "when person age is 19" do
          before { freeze_time(Time.local(2018, 12, 12, 12, 12)) }
          after { unfreeze_time }

          it "animal is valid" do
            person = build_stubbed(:person, birthdate_on: Date.new(1999, 10, 10))
            animal = build_stubbed(:animal, owner: person, animal_kind: :swallow)

            expect(animal).to be_valid
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
