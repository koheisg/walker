class Item < ApplicationRecord
  belongs_to :feed
  default_scope {order(id: :desc)}
end
