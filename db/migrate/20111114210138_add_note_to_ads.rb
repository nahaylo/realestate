class AddNoteToAds < ActiveRecord::Migration
  def change
    add_column :ads, :note, :text
  end
end
