class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :suggestion
  validates :direction, numericality: { less_than_or_equal_to: 1, greater_than_or_equal_to: -1 }
end
