class Prefecture < ApplicationRecord
  include ActiveHash::Associations
  has_many :items
end
