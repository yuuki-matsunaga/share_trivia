class CreateLevelSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :level_settings do |t|
      t.integer :level, null: false, default: 1
      t.integer :thresold,null: false, default: 0
      t.timestamps
    end
  end
end
