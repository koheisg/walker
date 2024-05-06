class OgpJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: false

  discard_on ActiveJob::DeserializationError, ActiveRecord::RecordNotUnique, Ferrum::NodeNotFoundError

  # Try nokogiri at first.
  # on failuser headless browser.
  #
  # headless browser use many memories, unstable on multi thread.
  def perform(item)
    item.item_ogp || item.create_item_ogp(OgpParser.call(item.link))
  end
end
