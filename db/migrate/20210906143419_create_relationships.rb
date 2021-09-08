class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false, default: ""
      t.integer :followed_id, null: false, default: ""
      t.timestamps
    end
  end
end
