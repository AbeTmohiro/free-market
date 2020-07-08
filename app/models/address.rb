class Address < ApplicationRecord
  validates :prefecture_id, :city, :house_number, :postal_code, presence: true
  belongs_to :user, optional: true
end
