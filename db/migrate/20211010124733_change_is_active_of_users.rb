class ChangeIsActiveOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :exp, :integer, null: false, default: 0
  end

  def down
    change_column :users, :exp, :integer
  end
end
