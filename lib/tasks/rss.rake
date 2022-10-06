namespace :rss do
  task import_items: :environment do
    Feed.where(archive: false).find_each do |feed|
      RssJob.perform_later(feed)
    end
  end
end
