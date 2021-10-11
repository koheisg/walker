class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError
  retry_on OpenURI::HTTPError, wait: 5.minutes, queue: :low_priority
  retry_on Net::ReadTimeout, wait: 5.minutes, queue: :low_priority
  retry_on Net::OpenTimeout, wait: 5.minutes, queue: :low_priority

  def perform(item)
    ItemOgp.create_or_find_by(item_id: item.id) do |ogp|
      if doc = document_from(item.link)

        ogp.assign_attributes(
          title: doc.css('meta[property="og:title"]/@content').text,
          og_type: doc.css('meta[property="og:type"]/@content').text,
          description: doc.css('meta[property="og:description"]/@content').text,
          url: doc.css('meta[property="og:url"]/@content').text,
          site_name: doc.css('meta[property="og:site_name"]/@content').text,
          image: doc.css('meta[property="og:image"]/@content').text
        )
      end
    end
  end

  private
    def document_from(url)
      Nokogiri::HTML(URI.open(url))
    end
end
