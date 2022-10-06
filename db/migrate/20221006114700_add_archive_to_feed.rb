class AddArchiveToFeed < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :archive, :boolean, default: false
  end
end
