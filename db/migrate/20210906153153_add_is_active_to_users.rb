class AddIsActiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_active, :boolean, null: false, default: true
  end
end
