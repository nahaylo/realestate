class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :location_id
      t.integer :ad_type
      t.string :ad
      t.string :phone
      t.decimal :price, :precision => 15, :scale => 2
      t.integer :price_type
      t.integer :rate, :default => 0

      t.timestamps
    end

    add_index :ads, :location_id
  end
end
