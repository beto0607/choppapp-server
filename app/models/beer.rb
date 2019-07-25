class Beer < ApplicationRecord
  belongs_to :producer
  belongs_to :beer_type
  
  validates :name, presence: true
  validates :description, presence: true

  has_many :votes, dependent: :destroy

  
  before_create do #Sets status to "ACTIVE" as default
    self.status = "ACTIVE"
  end
end
