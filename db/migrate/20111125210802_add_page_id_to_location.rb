class AddPageIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :page_id, :integer
    add_column :locations, :page_sub_id, :integer
  end
end
