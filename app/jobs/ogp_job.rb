class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError, ActiveRecord::RecordNotUnique, Ferrum::NodeNotFoundError

  # Try nokogiri at first.
  # on failuser headless browser.
  #
  # headless browser use many memories, unstable on multi thread.
  def perform(item)
    item.create_item_ogp(parse(item.link))
  end
end
