class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.text :first_name
      t.text :last_name
      t.text :document
      t.date :birthdate_on

      t.timestamps
    end
  end
end
