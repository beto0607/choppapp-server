class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

end
