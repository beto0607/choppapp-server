class BeerType < ApplicationRecord
  has_many :beers, dependant: :nullify

  validates :name, presence: true
  validates :description, presence: true
end
