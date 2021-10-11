require 'rss'

class RssJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(feed)
    items = RSS::Parser.parse(feed.url)&.items

    Sentry.capture_message "cant get items feed_id: #{feed.id} url: #{feed.url}" if items.nil?

    items.each do |item|
      new_item = if item.class == RSS::Atom::Feed::Entry
        feed.items.create_or_find_by!(link: item.link.href) do |i|
          i.title = item.title.content
          i.description = item.summary&.content
          i.published_at = Time.zone.parse(item.published.content.to_s)
        end
      else
        feed.items.create_or_find_by!(link: item.link) do |i|
          i.title = item.title
          i.description = item.description
          i.published_at = item.try(:pubDate)
        end
      end

      OgpJob.perform_later(new_item)
    end
  end
end
