require 'rss'

class RssJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(feed)
    xml = Net::HTTP.get(URI.parse(feed.url))
    RSS::Parser.parse(xml).items.each do |item|
      if item.class == RSS::Atom::Feed::Entry
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
    end
  end
end
