class Place < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_many :suggestions
  has_many :users, through: :suggestions
end
