# frozen_string_literal: true

require "rails_helper"

describe AnimalKindValidators::SwallowValidator do
  before { freeze_time(Time.local(2019, 12, 12, 12)) }
  after { unfreeze_time }

  describe "constants" do
    subject { described_class }

    it { is_expected.to be_const_defined(:MINIMUM_AGE) }
  end

  it "validates animal owner's age" do
    person = build_stubbed(:person, birthdate_on: Date.new(2018, 12, 12))
    record = build_stubbed(:animal, owner: person, animal_kind: :swallow)

    described_class.new.validate(record)

    expect(record.errors.messages).to_not be_empty
  end
end
