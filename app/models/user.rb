class User < ApplicationRecord
  has_many :suggestions
  has_many :votes
  has_many :comments
  has_many :likes, through: :comments
  validates :name, :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { in: 6..20 }
  has_secure_password
end
