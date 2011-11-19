class CreateAdPrices < ActiveRecord::Migration
  def change
    create_table :ad_prices do |t|
      t.integer :ad_id
      t.decimal :price, :precision => 15, :scale => 2
      t.integer :price_type

      t.timestamps
    end

    add_index :ad_prices, :ad_id
  end
end
