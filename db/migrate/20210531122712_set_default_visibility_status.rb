class SetDefaultVisibilityStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :visibility_status, :boolean, default: true
  end
end
