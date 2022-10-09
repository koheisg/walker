class FeedGrouping < ApplicationRecord
  belongs_to :feed
  belongs_to :feed_group
end
