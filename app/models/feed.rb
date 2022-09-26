class Feed < ApplicationRecord
  has_many :items
  scope :default, -> { where(default: true) }
end
