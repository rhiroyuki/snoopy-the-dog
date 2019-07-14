# frozen_string_literal: true

FactoryBot.define do
  factory :animal do
    name        { "Snoopy" }
    monthly_fee { 99.99 }
    animal_kind { :dog }
    association :owner, factory: :person
  end
end
