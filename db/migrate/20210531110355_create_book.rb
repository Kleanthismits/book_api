class CreateBook < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :description
      t.boolean :visibility_status
      t.date :creation_date
      t.string :isbn
      t.references :author, null: false, foreign_key: true
      t.references :publisher, null: true, foreign_key: true

      t.timestamps
    end
  end
end
