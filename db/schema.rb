# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111125210802) do

  create_table "ad_prices", :force => true do |t|
    t.integer  "ad_id"
    t.decimal  "price",      :precision => 15, :scale => 2
    t.integer  "price_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_prices", ["ad_id"], :name => "index_ad_prices_on_ad_id"

  create_table "ads", :force => true do |t|
    t.integer  "location_id"
    t.integer  "ad_type"
    t.string   "ad"
    t.string   "phone"
    t.decimal  "price",       :precision => 15, :scale => 2
    t.integer  "price_type"
    t.integer  "rate",                                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
    t.text     "map_link"
  end

  add_index "ads", ["location_id"], :name => "index_ads_on_location_id"

  create_table "locations", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
    t.integer  "page_sub_id"
  end

end
