require 'rss'

class RssJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(feed)
    Sentry.set_extras(feed_id: feed.id, feed_url: feed.url)

    items = RSS::Parser.parse(feed.url, false)&.items

    Sentry.capture_message "cant get items feed_id: #{feed.id} url: #{feed.url}" if items.nil?

    items.each do |item|
      new_item = if item.class == RSS::Atom::Feed::Entry
                   feed.items.create_or_find_by!(link: item.link.href) do |i|
                     i.title = item.title.content
                     i.description = item.summary&.content
                     i.published_at = item&.published&.content&.to_s&.then { |pub| Time.zone.parse(pub) }
                   end
                 else
                   feed.items.create_or_find_by!(link: item.link) do |i|
                     i.title = item.title
                     i.description = item.description
                     i.published_at = item.try(:pubDate)
                   end
                 end

      OgpJob.perform_later(new_item) unless new_item.item_ogp
    end
  end
end
