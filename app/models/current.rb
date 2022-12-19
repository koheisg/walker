class Current < ActiveSupport::CurrentAttributes
  attribute :account, :user
  attribute :request_id, :user_agent, :ip_address

  resets { Time.zone = nil }

  def user=(user)
    super
    # self.account = user.account
    # Time.zone    = user.time_zone
  end

  def feeds
    Current.user&.feeds.presence || Feed.default
  end

  def feed_groups
    FeedGroup.default
  end
end
