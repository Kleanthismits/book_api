class CreatePublisher < ActiveRecord::Migration[6.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :telephone
      t.string :address

      t.timestamps
    end
  end
end
