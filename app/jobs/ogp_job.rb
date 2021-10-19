class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError, ActiveRecord::RecordNotUnique, Ferrum::NodeNotFoundError

  def perform(item)
    ItemOgp.find_or_create_by(item_id: item.id) do |ogp|
      browser = Ferrum::Browser.new(timeout: 15)
      browser.go_to(item.link)
      ogp.assign_attributes(
        title: browser.at_css('meta[property="og:title"]')&.attribute('content'),
        og_type: browser.at_css('meta[property="og:type"]')&.attribute('content'),
        description: browser.at_css('meta[property="og:description"]')&.attribute('content'),
        url: browser.at_css('meta[property="og:url"]')&.attribute('content'),
        site_name: browser.at_css('meta[property="og:site_name"]')&.attribute('content'),
        image: browser.at_css('meta[property="og:image"]')&.attribute('content')
      )
      browser.quit
    end
  end
end
