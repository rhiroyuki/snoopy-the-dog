# frozen_string_literal: true

require "rails_helper"

describe Person do
  subject(:person) { build_stubbed(:person) }

  describe "associations" do
    it { expect(person).to have_many(:animals) }
  end

  describe "constants" do
    subject { described_class }

    it { is_expected.to be_const_defined(:MONTHLY_FEE_SUM_LIMIT) }
  end

  describe "#age" do
    before { freeze_time(Time.local(2018, 12, 12, 12, 12, 12)) }
    after { unfreeze_time }

    it "returns the persons age" do
      person = build_stubbed(:person, birthdate_on: Date.new(2000, 8, 15))

      expect(person.age).to eq(18)
    end
  end
end
