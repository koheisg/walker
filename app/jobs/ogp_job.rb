class OgpJob < ApplicationJob
  def perform(item)
    ItemOgp.create_or_find_by(item_id: item.id) do |ogp|
      doc = Nokogiri::HTML(URI.open(item.link))

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
