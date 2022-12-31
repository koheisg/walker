class Feed < ApplicationRecord
  has_many :items
  has_many :feed_groupings, dependent: :destroy
  has_many :feed_group, through: :feed_groupings
  scope :default, -> { where(default: true) }
end
