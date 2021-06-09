#:nodoc:
class ChangeBookStatusAndIsbnColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :visibility_status, :boolean, null: false
    change_column :books, :isbn, :string, null: false
  end
end
