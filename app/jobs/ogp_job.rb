class OgpJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

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
      begin
        Nokogiri::HTML(URI.open(url))
      rescue => e
        Sentry.capture_exception(e)
        nil
      end
    end
end
