class AddUniqIndexToItemLink < ActiveRecord::Migration[6.1]
  def change
    add_index :items, [:feed_id, :link], unique: true
  end
end
