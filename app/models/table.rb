class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations

  def reserve(params)
    reservations.create(params)
  end
end
