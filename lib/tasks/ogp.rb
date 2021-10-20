namespace :ogp do
  task crawle: :environment do
    Item.left_joins(:item_ogp).where(item_ogp: {id: nil}).find_each do |item|
      OgpJob.perform_now(item)
    end
  end
end
