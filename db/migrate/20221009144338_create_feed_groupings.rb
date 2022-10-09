class CreateFeedGroupings < ActiveRecord::Migration[7.0]
  def change
    create_table :feed_groupings do |t|
      t.references :feed, null: false, foreign_key: true
      t.references :feed_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
