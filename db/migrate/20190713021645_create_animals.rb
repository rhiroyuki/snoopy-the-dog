class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.text :name
      t.decimal :monthly_fee, precision: 14, scale: 2
      t.references :person, null: false, foreign_key: true
      t.integer :animal_kind

      t.timestamps
    end
  end
end
