class Item < ApplicationRecord
  belongs_to :feed
  has_one :item_ogp
  default_scope { order(id: :desc) }
end
