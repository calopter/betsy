class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates  :label, :presence => true
end


