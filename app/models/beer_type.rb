class BeerType < ApplicationRecord
  has_many :beers, dependent: :nullify

  validates :name, presence: true
  validates :description, presence: true
end
