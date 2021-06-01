class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.date :birth_date

      t.timestamps
    end
    add_index :authors, :email, unique: true
  end
end
