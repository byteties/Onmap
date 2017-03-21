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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170321075839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "infomaps", force: :cascade do |t|
    t.string    "name_station"
    t.string    "name_location"
    t.string    "river"
    t.string    "sub_district"
    t.string    "district"
    t.geography "lonlat",        limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.geography "area",          limit: {:srid=>4326, :type=>"polygon", :geographic=>true}
    t.datetime  "created_at",                                                               null: false
    t.datetime  "updated_at",                                                               null: false
  end

  create_table "places", force: :cascade do |t|
    t.string    "name"
    t.string    "type"
    t.geography "lonlat",     limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer   "infomap_id"
    t.datetime  "created_at",                                                          null: false
    t.datetime  "updated_at",                                                          null: false
  end

  create_table "storages", force: :cascade do |t|
    t.integer  "infomap_id"
    t.string   "name_station"
    t.integer  "rain"
    t.integer  "temperatare"
    t.integer  "water_level"
    t.integer  "warning_level"
    t.integer  "critical_level"
    t.integer  "checkflood"
    t.integer  "checkrain"
    t.string   "time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
