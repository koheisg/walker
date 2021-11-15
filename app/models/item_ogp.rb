class ItemOgp < ApplicationRecord
  belongs_to :item
  validates :item, uniqueness: true
end
