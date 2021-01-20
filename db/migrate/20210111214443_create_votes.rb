class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :direction, null: false
      t.references :user, null: false, foreign_key: true
      t.references :suggestion, null: false, foreign_key: true
      t.timestamps
    end

    add_index :votes, [:user_id, :suggestion_id], :unique => true
  end
end
