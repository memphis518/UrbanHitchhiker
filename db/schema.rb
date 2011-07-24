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

ActiveRecord::Schema.define(:version => 20110723235248) do

  create_table "trips", :force => true do |t|
    t.string   "origin"
    t.string   "destination"
    t.string   "trip_type"
    t.string   "name"
    t.text     "comments"
    t.string   "transportation"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.time     "start_time"
    t.decimal  "origin_longitude"
    t.decimal  "origin_latitude"
    t.decimal  "destination_longitude"
    t.decimal  "destination_latitude"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.boolean  "active"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
