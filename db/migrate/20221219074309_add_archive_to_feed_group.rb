class AddArchiveToFeedGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :feed_groups, :default, :boolean, default: false
  end
end
