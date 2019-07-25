class Producer < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  belongs_to :user, dependent: :destroy
  has_many :beers, dependent: :destroy

  before_create do #Sets status to "ACTIVE" as default
    self.status = "ACTIVE"
  end
end
