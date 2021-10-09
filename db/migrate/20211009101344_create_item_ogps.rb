class CreateItemOgps < ActiveRecord::Migration[7.0]
  def change
    create_table :item_ogps do |t|
      t.references :item, index: {:unique=>true}, null: false, foreign_key: true
      t.string :title
      t.string :og_type
      t.string :description
      t.string :url
      t.string :site_name
      t.text :image

      t.timestamps
    end
  end
end
