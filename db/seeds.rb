# frozen_string_literal: true

def create(model, attributes)
  model_string = model.to_s

  result = model_string.capitalize.constantize.create(attributes)

  puts "#{model_string.upcase}: #{result.attributes.to_json}\n\n"
  result
end

puts "------ Seeding DB ------"

johnny = create(:person, {first_name: "Johnny", last_name: "Cash",      document: "555555555", birthdate_on: Date.new(1932, 2, 26)})
sid    = create(:person, {first_name: "Sid",    last_name: "Vicious",   document: "555555555", birthdate_on: Date.new(1957, 5, 10)})
axl    = create(:person, {first_name: "Axl",    last_name: "Rose",      document: "555555555", birthdate_on: Date.new(1962, 2, 6)})
joey   = create(:person, {first_name: "Joey",   last_name: "Ramone",    document: "555555555", birthdate_on: Date.new(1951, 5, 19)})
bruce  = create(:person, {first_name: "Bruce",  last_name: "Dickinson", document: "555555555", birthdate_on: Date.new(1958, 8, 7)})
kurt   = create(:person, {first_name: "Kurt",   last_name: "Cobain",    document: "555555555", birthdate_on: Date.new(1967, 2, 20)})
elvis  = create(:person, {first_name: "Elvis",  last_name: "Presley",   document: "555555555", birthdate_on: Date.new(2008, 8, 17)})

create(:animal, {name: "Pé de Pano",             monthly_fee: 199.99, animal_kind: :horse,    owner: johnny})
create(:animal, {name: "Rex",                    monthly_fee: 99.99,  animal_kind: :dog,      owner: sid})
create(:animal, {name: "Ajudante do Papai Noel", monthly_fee: 99.99,  animal_kind: :dog,      owner: axl})
create(:animal, {name: "Rex",                    monthly_fee: 103.99, animal_kind: :parrot,   owner: joey})
create(:animal, {name: "Flora",                  monthly_fee: 103.99, animal_kind: :llama,    owner: bruce})
create(:animal, {name: "Dino",                   monthly_fee: 177.99, animal_kind: :iguana,   owner: kurt})
create(:animal, {name: "Lassie",                 monthly_fee: 407.99, animal_kind: :platypus, owner: elvis})

puts "----- Seeding finished ------"
