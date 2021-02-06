class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :feed, null: false, foreign_key: true
      t.string :title
      t.string :link
      t.string :description

      t.timestamps
    end
  end
end
