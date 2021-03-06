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

ActiveRecord::Schema.define(version: 20180124052703) do

  create_table "area_code_forecasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_code_forecast"
    t.string "area_name"
  end

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_code"
    t.string "area_name"
    t.integer "area_code_forecast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "user_id"
    t.string "title"
    t.string "body"
    t.integer "flag"
  end

  create_table "farms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "farm_name"
    t.string "farm_address"
    t.string "varchar"
  end

  create_table "logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "log_title"
    t.string "body"
    t.integer "user_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "body"
    t.integer "user_id"
    t.text "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "place_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "byid"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "username"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_code"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_views_on_email", unique: true
    t.index ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true
  end

  create_table "weather_forecasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_code_forecast", null: false
    t.string "time_id_1"
    t.string "time_id_2"
    t.string "time_id_3"
    t.string "weather_1"
    t.string "weather_2"
    t.string "weather_3"
    t.string "wind_1"
    t.string "wind_2"
    t.string "wind_3"
    t.string "rain_time_id_1"
    t.string "rain_time_id_2"
    t.string "rain_time_id_3"
    t.string "rain_time_id_4"
    t.string "rain_time_id_5"
    t.string "rain_time_id_6"
    t.string "rain_1"
    t.string "rain_2"
    t.string "rain_3"
    t.string "rain_4"
    t.string "rain_5"
    t.string "rain_6"
    t.string "max_min_temperature_time_id_1"
    t.string "max_min_temperature_time_id_2"
    t.string "max_min_temperature_time_id_3"
    t.string "max_min_temperature_time_id_4"
    t.string "max_min_temperature_1"
    t.string "max_min_temperature_2"
    t.string "max_min_temperature_3"
    t.string "max_min_temperature_4"
    t.string "weather_detail_time_id_1"
    t.string "weather_detail_time_id_2"
    t.string "weather_detail_time_id_3"
    t.string "weather_detail_time_id_4"
    t.string "weather_detail_time_id_5"
    t.string "weather_detail_time_id_6"
    t.string "weather_detail_time_id_7"
    t.string "weather_detail_time_id_8"
    t.string "weather_detail_time_id_9"
    t.string "weather_detail_time_id_10"
    t.string "weather_detail_1"
    t.string "weather_detail_2"
    t.string "weather_detail_3"
    t.string "weather_detail_4"
    t.string "weather_detail_5"
    t.string "weather_detail_6"
    t.string "weather_detail_7"
    t.string "weather_detail_8"
    t.string "weather_detail_9"
    t.string "weather_detail_10"
    t.string "temperature_time_id_1"
    t.string "temperature_time_id_2"
    t.string "temperature_time_id_3"
    t.string "temperature_time_id_4"
    t.string "temperature_time_id_5"
    t.string "temperature_time_id_6"
    t.string "temperature_time_id_7"
    t.string "temperature_time_id_8"
    t.string "temperature_time_id_9"
    t.string "temperature_1"
    t.string "temperature_2"
    t.string "temperature_3"
    t.string "temperature_4"
    t.string "temperature_5"
    t.string "temperature_6"
    t.string "temperature_7"
    t.string "temperature_8"
    t.string "temperature_9"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "max_min_temperature_type_1"
    t.string "max_min_temperature_type_2"
    t.string "max_min_temperature_type_3"
    t.string "max_min_temperature_type_4"
  end

  create_table "weather_informations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "area_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time"
    t.string "temperature"
    t.string "rain"
    t.string "wind_direction"
    t.string "wind_speed"
    t.string "sun"
  end

end
