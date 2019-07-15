# frozen_string_literal: true

require "rails_helper"

describe MonthlyFeeLimitValidator do
  it "doesnt add an error to the record" do
    owner = create(:person)

    dog = build(:animal, monthly_fee: 200.01, owner: owner)

    described_class.new.validate(dog)

    expect(dog.errors.messages).to be_empty
  end

  context "when invalid" do
    it "adds an error to the record" do
      animals = [build(:animal, monthly_fee: 800.00)]
      owner = create(:person, animals: animals)

      dog = build(:animal, monthly_fee: 200.01, owner: owner)

      described_class.new.validate(dog)

      expect(dog.errors.messages).to_not be_empty
    end
  end
end
