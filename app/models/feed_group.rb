class FeedGroup < ApplicationRecord
  has_many :feed_groupings, dependent: :destroy
  has_many :feeds, through: :feed_groupings

  scope :default, -> { where(default: true) }
end
