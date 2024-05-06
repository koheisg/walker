class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError, ActiveRecord::RecordNotUnique, Ferrum::NodeNotFoundError

  # Try nokogiri at first.
  # on failuser headless browser.
  #
  # headless browser use many memories, unstable on multi thread.
  def perform(item)
    Sentry.set_extras(item_id: item.id, item_link: item.link)

    item.item_ogp || item.create_item_ogp(OgpParser.call(item.link))
  end
end
