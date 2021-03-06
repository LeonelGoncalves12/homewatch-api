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

ActiveRecord::Schema.define(version: 20190722175948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.string "city", null: false
    t.string "wind", null: false
    t.string "humidity", null: false
    t.string "sunrise", null: false
    t.string "sunset", null: false
    t.string "icon", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "temperature"
    t.index ["user_id"], name: "index_conditions_on_user_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "cron"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "homes", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.string "tunnel", null: false
    t.inet "ip_address", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "delayed_job_id"
    t.index ["delayed_job_id"], name: "index_homes_on_delayed_job_id"
    t.index ["user_id"], name: "index_homes_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.string "icon"
    t.bigint "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["home_id"], name: "index_rooms_on_home_id"
  end

  create_table "scenario_things", id: :serial, force: :cascade do |t|
    t.integer "thing_id"
    t.integer "scenario_id"
    t.json "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scenario_id"], name: "index_scenario_things_on_scenario_id"
    t.index ["thing_id"], name: "index_scenario_things_on_thing_id"
  end

  create_table "scenarios", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.integer "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["home_id"], name: "index_scenarios_on_home_id"
  end

  create_table "statistics", force: :cascade do |t|
    t.string "thingID"
    t.json "status"
    t.bigint "user_id"
    t.bigint "delayed_job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timed_task"
    t.string "counter"
    t.string "cron"
    t.string "triggered_task"
    t.string "scenario"
    t.index ["delayed_job_id"], name: "index_statistics_on_delayed_job_id"
    t.index ["user_id"], name: "index_statistics_on_user_id"
  end

  create_table "things", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "subtype"
    t.json "connection_info"
    t.integer "room_id"
    t.string "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["room_id"], name: "index_things_on_room_id"
  end

  create_table "timed_tasks", id: :serial, force: :cascade do |t|
    t.integer "home_id"
    t.integer "delayed_job_id"
    t.integer "thing_id"
    t.json "status_to_apply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scenario_id"
    t.index ["delayed_job_id"], name: "index_timed_tasks_on_delayed_job_id"
    t.index ["home_id"], name: "index_timed_tasks_on_home_id"
    t.index ["scenario_id"], name: "index_timed_tasks_on_scenario_id"
    t.index ["thing_id"], name: "index_timed_tasks_on_thing_id"
  end

  create_table "triggered_tasks", id: :serial, force: :cascade do |t|
    t.integer "home_id", null: false
    t.integer "thing_id"
    t.integer "thing_to_compare_id", null: false
    t.integer "scenario_id"
    t.integer "delayed_job_id"
    t.json "status_to_apply"
    t.json "status_to_compare", null: false
    t.string "comparator", null: false
    t.boolean "should_apply?", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display"
    t.index ["delayed_job_id"], name: "index_triggered_tasks_on_delayed_job_id"
    t.index ["home_id"], name: "index_triggered_tasks_on_home_id"
    t.index ["scenario_id"], name: "index_triggered_tasks_on_scenario_id"
    t.index ["thing_id"], name: "index_triggered_tasks_on_thing_id"
    t.index ["thing_to_compare_id"], name: "index_triggered_tasks_on_thing_to_compare_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "timed_tasks", "homes"
  add_foreign_key "timed_tasks", "scenarios"
  add_foreign_key "timed_tasks", "things"
  add_foreign_key "triggered_tasks", "homes"
  add_foreign_key "triggered_tasks", "scenarios"
  add_foreign_key "triggered_tasks", "things"
  add_foreign_key "triggered_tasks", "things", column: "thing_to_compare_id"
end
