class SuggestionScore < ApplicationRecord
  belongs_to :suggestion

  def self.refresh_all
    ActiveRecord::Base.connection.execute("
      INSERT INTO suggestion_scores (suggestion_id, score)
      SELECT v.suggestion_id, SUM(v.direction) AS score
      FROM votes AS v
      GROUP BY 1
      ON CONFLICT (suggestion_id) DO UPDATE SET score = excluded.score;
    ")
  end
end
