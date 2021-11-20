xml.instruct! :xml, :version => "1.0"
xml.rss(
  # "version" => "2.0",
  # "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  # "xmlns:wfw" => "http://wellformedweb.org/CommentAPI/",
  # "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  # "xmlns:atom" => "http://www.w3.org/2005/Atom",
  # "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/",
  # "xmlns:slash" => "http://purl.org/rss/1.0/modules/slash/"
  "version" => "2.0",
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/"
) do
  xml.channel do
    xml.title @feed.name
    xml.description "#{@feed.name}の説明" # TODO
    xml.link feed_items_url(utm_medium: 'rss')
    xml.pubDate @ref_time.rfc822
    xml.language "ja" # TODO localeから選択 'ja-ja' かも確認
    # xml.ttl "40" # TODO cacheあった方がいいんじゃないかな？
    # xml.atom :link, "href" => "RSSのURL", "rel" => "self", "type" => "application/rss+xml" TODO 必要なさそう
    xml.image do
      xml.url 'https://b.hatena.ne.jp/favicon.ico'
      xml.title @feed.name
      xml.link feed_daily_url(date: @ref_time.strftime("%Y%m%d"), utm_medium: 'rss')
      xml.width 32
      xml.height 32
    end
    xml.generator root_url
    @items_set.each do |date, items|
      xml.item do
        xml.title "#{@feed.name} #{date}"
        xml.link feed_daily_url(date: date.strftime("%Y%m%d"), utm_medium: 'rss')
        xml.pubDate (date + 1.day).to_time
        xml.content(:encoded) do
          xml.cdata!(
            (items.first(3).map { |item| item.title }.join(" / ")).truncate(140)
          )
        end
        xml.dc :creator, @feed.name
      end
    end
  end
end
