class SuggestionScores < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestion_scores do |t|
      t.references :suggestion, null: false, foreign_key: true
      t.integer :score
    end
    add_index :suggestion_scores, [:suggestion_id], :unique => true, name: "index_suggestion_scores_on_suggestion_id_uniq"
  end
end
