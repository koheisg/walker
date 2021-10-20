class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError, ActiveRecord::RecordNotUnique, Ferrum::NodeNotFoundError

  # Try nokogiri at first.
  # on failuser headless browser.
  #
  # headless browser use many memories, unstable on multi thread.
  def perform(item)
    ItemOgp.find_or_create_by(item_id: item.id) do |ogp|
      begin
        doc = Nokogiri::HTML(URI.open(item.link))
        attrs = doc.then do |doc|
          {
            title: doc.css('meta[property="og:title"]/@content').text,
            og_type: doc.css('meta[property="og:type"]/@content').text,
            description: doc.css('meta[property="og:description"]/@content').text,
            url: doc.css('meta[property="og:url"]/@content').text,
            site_name: doc.css('meta[property="og:site_name"]/@content').text,
            image: doc.css('meta[property="og:image"]/@content').text
          }
        end
      rescue
        begin
          browser.go_to(item.link)
          attrs = browser.then do |browser|
            {
              title: browser.at_css('meta[property="og:title"]')&.attribute('content'),
              og_type: browser.at_css('meta[property="og:type"]')&.attribute('content'),
              description: browser.at_css('meta[property="og:description"]')&.attribute('content'),
              url: browser.at_css('meta[property="og:url"]')&.attribute('content'),
              site_name: browser.at_css('meta[property="og:site_name"]')&.attribute('content'),
              image: browser.at_css('meta[property="og:image"]')&.attribute('content')
            }
          end
        ensure
          browser.quit
        end
      end

      ogp.assign_attributes(attrs)
    end
  end

  private
    def browser
      @browser ||= Ferrum::Browser.new(timeout: 15, process_timeout: 60)
    end
end
