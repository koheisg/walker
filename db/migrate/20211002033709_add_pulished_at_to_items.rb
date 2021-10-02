class AddPulishedAtToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :published_at, :datetime
  end
end
