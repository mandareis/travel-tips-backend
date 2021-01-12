class User < ApplicationRecord
  has_many :suggestions
  has_many :votes
  has_many :comments
  has_many :likes, through: :comments
end
