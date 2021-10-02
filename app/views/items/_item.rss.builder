xml.item do
  xml.title item.title
  xml.link item.link
  xml.pubDate item.published_at&.rfc822
  xml.description item.description
  xml.content(:encoded) do
    xml.cdata!("<p><a href=\"#{item.link}\">#{item.title}</a></p>")
  end
  xml.dc :creator, item.feed.name
end
