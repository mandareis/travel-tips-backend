class Suggestion < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  has_many :votes
  has_one :suggestion_score
  validates :title, :description, presence: true
end
