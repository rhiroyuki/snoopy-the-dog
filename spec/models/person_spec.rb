# frozen_string_literal: true

require "rails_helper"

describe Person do
  subject(:person) { build_stubbed(:person) }

  describe "associations" do
    it { expect(person).to have_many(:animals) }
  end
end
