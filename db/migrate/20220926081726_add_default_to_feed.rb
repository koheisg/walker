class AddDefaultToFeed < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :default, :boolean
  end
end
