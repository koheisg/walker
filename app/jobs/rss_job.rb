require 'rss'

class RssJob < ApplicationJob
  queue_as :default

  def perform(feed)
    xml = Net::HTTP.get(URI.parse(feed.url))
    RSS::Parser.parse(xml).items.each do |item|
      feed.items.create_or_find_by!(link: item.link) do |i|
        i.title = item.title
        i.description = item.description
      end
    end
  end
end
