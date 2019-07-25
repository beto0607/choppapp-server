class Producer < ApplicationRecord
    validates :name, uniqueness: true, presense: true
    validates :description, presense: true

    belongs_to :user, dependent: :destroy
    has_many :beers, dependent: :destroy
end
