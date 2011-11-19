class AddMapLinkToAds < ActiveRecord::Migration
  def change
    add_column :ads, :map_link, :text
  end
end
