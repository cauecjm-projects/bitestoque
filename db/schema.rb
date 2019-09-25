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

ActiveRecord::Schema.define(version: 2019_09_18_040452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_products", force: :cascade do |t|
    t.integer "qtd", null: false
    t.bigint "product_id", null: false
    t.bigint "color_id", null: false
    t.bigint "size_id", null: false
    t.index ["color_id"], name: "index_available_products_on_color_id"
    t.index ["product_id"], name: "index_available_products_on_product_id"
    t.index ["qtd"], name: "index_available_products_on_qtd"
    t.index ["size_id"], name: "index_available_products_on_size_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "code", limit: 10, null: false
    t.index ["name"], name: "index_colors_on_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "description"
    t.index ["name"], name: "index_products_on_name"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.text "description"
    t.index ["name"], name: "index_sizes_on_name"
  end

  add_foreign_key "available_products", "colors"
  add_foreign_key "available_products", "products"
  add_foreign_key "available_products", "sizes"
end
