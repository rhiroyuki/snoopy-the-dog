# frozen_string_literal: true

require "rails_helper"

describe AnimalKindValidator do
  context "when validator exists" do
    it "calls the validator" do
      record = build_stubbed(:animal, animal_kind: :swallow)
      allow(AnimalKindValidators::SwallowValidator).to receive(:new)
        .and_call_original

      described_class.new.validate(record)

      expect(AnimalKindValidators::SwallowValidator).to have_received(:new)
    end
  end

  context "when validator doesnt exists" do
    it "does nothing" do
      record = build_stubbed(:animal)
      allow(record).to receive(:animal_kind).and_return(:blargh)

      expect(described_class.new.validate(record)).to be_nil
    end
  end

  context "when animal kind is nil" do
    it "does nothing" do
      record = build_stubbed(:animal)
      allow(record).to receive(:animal_kind).and_return(nil)

      expect(described_class.new.validate(record)).to be_nil
    end
  end
end
