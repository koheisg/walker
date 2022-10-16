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

  private
    def parse(url)
      begin
        attrs = parse_by_nokogiri_with_uri(url)
      rescue
        begin
          attrs = parse_by_browser(url)
        ensure
          browser.quit
        end
      end
      attrs
    end

    def parse_by_nokogiri_with_uri(url)
      doc = Nokogiri::HTML(URI.open(url))
      doc.then do |doc|
        {
          title: doc.css('meta[property="og:title"]/@content').text,
          og_type: doc.css('meta[property="og:type"]/@content').text,
          description: doc.css('meta[property="og:description"]/@content').text,
          url: doc.css('meta[property="og:url"]/@content').text,
          site_name: doc.css('meta[property="og:site_name"]/@content').text,
          image: doc.css('meta[property="og:image"]/@content').text
        }
      end
    end

    def parse_by_browser(url)
      browser.go_to(url)
      browser.then do |browser|
        {
          title: browser.at_css('meta[property="og:title"]')&.attribute('content'),
          og_type: browser.at_css('meta[property="og:type"]')&.attribute('content'),
          description: browser.at_css('meta[property="og:description"]')&.attribute('content'),
          url: browser.at_css('meta[property="og:url"]')&.attribute('content'),
          site_name: browser.at_css('meta[property="og:site_name"]')&.attribute('content'),
          image: browser.at_css('meta[property="og:image"]')&.attribute('content')
        }
      end
    end

    def browser
      @browser ||= Ferrum::Browser.new(timeout: 15, process_timeout: 60)
    end
end
