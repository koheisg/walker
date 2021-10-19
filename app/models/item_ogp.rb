class ItemOgp < ApplicationRecord
  belongs_to :item

  validates :title, :og_type, :description, :url, :site_name, :image, presence: true
end
