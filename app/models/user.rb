class User < ApplicationRecord
  has_secure_password
  has_many :suggestions
  has_many :votes
  has_many :comments
  has_many :likes, through: :comments
  validates :email, :username, uniqueness: :true
end
