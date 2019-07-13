# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    first_name   { "Fausto" }
    last_name    { "Silva" }
    document     { "5555555" }
    birthdate_on { Date.new(2019, 12, 10) }
  end
end
