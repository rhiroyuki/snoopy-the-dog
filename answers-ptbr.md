## Questões

As questões devem ser respondidas com queries do `ActiveRecord`.
Inclua os trechos de código que respondem as perguntas abaixo:

### Qual é o custo médio dos animais do tipo cachorro?
`Animal.dog.average(:monthly_fee)`

```
pry(main)> Animal.dog.average(:monthly_fee)
   (0.7ms)  SELECT AVG("animals"."monthly_fee") FROM "animals" WHERE "animals"."animal_kind" = $1  [["animal_kind", 2]]
=> 0.9999e2
```

### Quantos cachorros existem no sistema?
`Animal.dog.count`

```
pry(main)> Animal.dog.count
   (0.8ms)  SELECT COUNT(*) FROM "animals" WHERE "animals"."animal_kind" = $1  [["animal_kind", 2]]
=> 2
```

### Qual o nome dos donos dos cachorros (Array de nomes)?
`Animal.dog.includes(:owner).references(:owner).pluck("CONCAT_WS(' ', people.first_name, people.last_name)")`

```
pry(main)> Animal.dog.includes(:owner).references(:owner).pluck(Arel.sql("CONCAT_WS(' ', people.first_name, people.last_name)"))
   (1.0ms)  SELECT CONCAT_WS(' ', people.first_name, people.last_name) FROM "animals" LEFT OUTER JOIN "people" ON "people"."id" = "animals"."person_id" WHERE "animals"."animal_kind" = $1  [["animal_kind", 2]]
=> ["Sid Vicious", "Axl Rose"]
```

### Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)

`# A query orderna pela soma do custo mensal dos animais do dono e retorna todas as pessoas mesmo se algumas não tiverem animais`
`Person.left_outer_joins(:animals).group('people.id').order(Arel.sql('COALESCE(SUM(animals.monthly_fee), 0) DESC'))`

```
pry(main)> Person.left_outer_joins(:animals).group(:id).order(Arel.sql('COALESCE(SUM(animals.monthly_fee), 0) DESC'))
  Person Load (1.1ms)  SELECT "people".* FROM "people" LEFT OUTER JOIN "animals" ON "animals"."person_id" = "people"."id" GROUP BY "people"."id" ORDER BY COALESCE(SUM(animals.monthly_fee), 0) DESC
=> [#<Person:0x000055a8a6015d48
  id: 7,
  first_name: "Elvis",
  last_name: "Presley",
  document: "555555555",
  birthdate_on: Sun, 17 Aug 2008,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015c80
  id: 1,
  first_name: "Johnny",
  last_name: "Cash",
  document: "555555555",
  birthdate_on: Fri, 26 Feb 1932,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015bb8
  id: 6,
  first_name: "Kurt",
  last_name: "Cobain",
  document: "555555555",
  birthdate_on: Mon, 20 Feb 1967,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015af0
  id: 4,
  first_name: "Joey",
  last_name: "Ramone",
  document: "555555555",
  birthdate_on: Sat, 19 May 1951,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015a28
  id: 5,
  first_name: "Bruce",
  last_name: "Dickinson",
  document: "555555555",
  birthdate_on: Thu, 07 Aug 1958,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015960
  id: 3,
  first_name: "Axl",
  last_name: "Rose",
  document: "555555555",
  birthdate_on: Tue, 06 Feb 1962,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>,
 #<Person:0x000055a8a6015898
  id: 2,
  first_name: "Sid",
  last_name: "Vicious",
  document: "555555555",
  birthdate_on: Fri, 10 May 1957,
  created_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00,
  updated_at: Mon, 15 Jul 2019 02:07:06 UTC +00:00>]
```

### Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?

`# Retorna um hash com { id: monthly_fee * 3 }`
`Person.includes(:animals).references(:animals).group('people.id').sum('animals.monthly_fee * 3')`

```
pry(main)> Person.includes(:animals).references(:animals).group('people.id').sum('animals.monthly_fee * 3')
   (1.2ms)  SELECT SUM(animals.monthly_fee * 3) AS sum_animals_monthly_fee_all_3, people.id AS people_id FROM "people" LEFT OUTER JOIN "animals" ON "animals"."person_id" = "people"."id" GROUP BY people_id
=> {4=>0.31197e3, 6=>0.53397e3, 2=>0.29997e3, 3=>0.29997e3, 5=>0.31197e3, 7=>0.122397e4, 1=>0.59997e3}
```

