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
    xml.link @feed.url
    xml.pubDate Time.current.rfc822
    xml.language "ja" # TODO localeから選択 'ja-ja' かも確認
    # xml.ttl "40" # TODO cacheあった方がいいんじゃないかな？
    # xml.atom :link, "href" => "RSSのURL", "rel" => "self", "type" => "application/rss+xml" TODO 必要なさそう
    xml.generator root_url
    xml << (render(@page.records).gsub(/^/, '    ')) if @page.records.size.positive?
  end
end
