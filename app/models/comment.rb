class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
  has_many :likes
end
