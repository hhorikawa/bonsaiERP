# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_05_114314) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"

  create_table "account_ledgers", force: :cascade do |t|
    t.text "reference"
    t.string "currency"
    t.integer "account_id"
    t.decimal "account_balance", precision: 14, scale: 2, default: "0.0"
    t.integer "account_to_id"
    t.decimal "account_to_balance", precision: 14, scale: 2, default: "0.0"
    t.date "date"
    t.string "operation", limit: 20
    t.decimal "amount", precision: 14, scale: 2, default: "0.0"
    t.decimal "exchange_rate", precision: 14, scale: 4, default: "1.0"
    t.integer "creator_id"
    t.integer "approver_id"
    t.datetime "approver_datetime", precision: nil
    t.integer "nuller_id"
    t.datetime "nuller_datetime", precision: nil
    t.boolean "inverse", default: false
    t.boolean "has_error", default: false
    t.string "error_messages"
    t.string "status", limit: 50, default: "approved"
    t.integer "project_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "updater_id"
    t.string "name"
    t.integer "contact_id"
    t.index ["account_id"], name: "index_account_ledgers_on_account_id"
    t.index ["account_to_id"], name: "index_account_ledgers_on_account_to_id"
    t.index ["contact_id"], name: "index_account_ledgers_on_contact_id"
    t.index ["currency"], name: "index_account_ledgers_on_currency"
    t.index ["date"], name: "index_account_ledgers_on_date"
    t.index ["has_error"], name: "index_account_ledgers_on_has_error"
    t.index ["name"], name: "index_account_ledgers_on_name", unique: true
    t.index ["operation"], name: "index_account_ledgers_on_operation"
    t.index ["project_id"], name: "index_account_ledgers_on_project_id"
    t.index ["status"], name: "index_account_ledgers_on_status"
    t.index ["updater_id"], name: "index_account_ledgers_on_updater_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "currency", limit: 3, null: false
    t.boolean "active", default: true, null: false
    t.text "description", null: false
    t.string "accountable_type", limit: 80, null: false
    t.string "accountable_id", null: false
    t.decimal "exchange_rate", precision: 14, scale: 4, default: "1.0"
    t.decimal "amount", precision: 14, scale: 2, default: "0.0"
    t.date "date"
    t.string "state", limit: 30
    t.boolean "has_error", default: false
    t.string "error_messages", limit: 400
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "tag_ids", default: [], array: true
    t.integer "updater_id"
    t.decimal "tax_percentage", precision: 5, scale: 2, default: "0.0"
    t.integer "tax_id"
    t.decimal "total", precision: 14, scale: 2, default: "0.0"
    t.boolean "tax_in_out", default: false
    t.jsonb "extras"
    t.integer "creator_id"
    t.integer "approver_id"
    t.integer "nuller_id"
    t.index ["approver_id"], name: "index_accounts_on_approver_id"
    t.index ["creator_id"], name: "index_accounts_on_creator_id"
    t.index ["extras"], name: "index_accounts_on_extras"
    t.index ["nuller_id"], name: "index_accounts_on_nuller_id"
    t.index ["tag_ids"], name: "index_accounts_on_tag_ids"
    t.index ["tax_id"], name: "index_accounts_on_tax_id"
    t.index ["tax_in_out"], name: "index_accounts_on_tax_in_out"
    t.index ["updater_id"], name: "index_accounts_on_updater_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "attachment_uid"
    t.string "name"
    t.integer "attachable_id"
    t.string "attachable_type"
    t.integer "user_id"
    t.integer "position", default: 0
    t.boolean "image", default: false
    t.integer "size"
    t.json "image_attributes"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "publish", default: false
    t.index ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type"
    t.index ["image"], name: "index_attachments_on_image"
    t.index ["publish"], name: "index_attachments_on_publish"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "cashes", force: :cascade do |t|
    t.string "bank_name", comment: "銀行名+支店名"
    t.string "bank_addr"
    t.string "account_no"
    t.string "account_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_no"], name: "index_cashes_on_account_no", unique: true
  end

  create_table "contact_accounts", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.string "bank_name", comment: "銀行名+支店名"
    t.string "bank_addr"
    t.string "account_no"
    t.string "account_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id", "account_no"], name: "index_contact_accounts_on_contact_id_and_account_no", unique: true
    t.index ["contact_id"], name: "index_contact_accounts_on_contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "matchcode"
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.string "organisation_name", limit: 100
    t.string "address", limit: 250
    t.string "phone", limit: 40
    t.string "mobile", limit: 40
    t.string "email", limit: 200
    t.string "tax_number", limit: 30
    t.string "aditional_info", limit: 250
    t.string "code"
    t.string "type"
    t.string "position"
    t.boolean "active", default: true
    t.boolean "staff", default: false
    t.boolean "client", default: false
    t.boolean "supplier", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "incomes_status", limit: 300, default: "{}"
    t.string "expenses_status", limit: 300, default: "{}"
    t.integer "tag_ids", default: [], array: true
    t.index ["active"], name: "index_contacts_on_active"
    t.index ["client"], name: "index_contacts_on_client"
    t.index ["first_name"], name: "index_contacts_on_first_name"
    t.index ["last_name"], name: "index_contacts_on_last_name"
    t.index ["matchcode"], name: "index_contacts_on_matchcode"
    t.index ["staff"], name: "index_contacts_on_staff"
    t.index ["supplier"], name: "index_contacts_on_supplier"
    t.index ["tag_ids"], name: "index_contacts_on_tag_ids"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "historiable_id"
    t.boolean "new_item", default: false
    t.string "historiable_type"
    t.json "history_data", default: {}
    t.datetime "created_at", precision: nil
    t.string "klass_type"
    t.text "extras"
    t.json "all_data", default: {}
    t.index ["created_at"], name: "index_histories_on_created_at"
    t.index ["historiable_id", "historiable_type"], name: "index_histories_on_historiable_id_and_historiable_type"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "store_id"
    t.integer "account_id"
    t.date "date"
    t.string "ref_number"
    t.string "operation", limit: 10
    t.string "description"
    t.decimal "total", precision: 14, scale: 2, default: "0.0"
    t.integer "creator_id"
    t.integer "transference_id"
    t.integer "store_to_id"
    t.integer "project_id"
    t.boolean "has_error", default: false
    t.string "error_messages"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "updater_id"
    t.index ["account_id"], name: "index_inventories_on_account_id"
    t.index ["contact_id"], name: "index_inventories_on_contact_id"
    t.index ["date"], name: "index_inventories_on_date"
    t.index ["has_error"], name: "index_inventories_on_has_error"
    t.index ["operation"], name: "index_inventories_on_operation"
    t.index ["project_id"], name: "index_inventories_on_project_id"
    t.index ["ref_number"], name: "index_inventories_on_ref_number"
    t.index ["store_id"], name: "index_inventories_on_store_id"
    t.index ["updater_id"], name: "index_inventories_on_updater_id"
  end

  create_table "inventory_details", force: :cascade do |t|
    t.integer "inventory_id"
    t.integer "item_id"
    t.integer "store_id"
    t.decimal "quantity", precision: 14, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["inventory_id"], name: "index_inventory_details_on_inventory_id"
    t.index ["item_id"], name: "index_inventory_details_on_item_id"
    t.index ["store_id"], name: "index_inventory_details_on_store_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.decimal "price", precision: 14, scale: 2, default: "0.0", null: false
    t.string "name", limit: 255, null: false
    t.string "description", null: false
    t.string "code", limit: 100, null: false
    t.boolean "for_sale", default: true, null: false
    t.boolean "stockable", default: true, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.decimal "buy_price", precision: 14, scale: 2, default: "0.0", null: false
    t.string "unit_symbol", limit: 20
    t.string "unit_name", limit: 255
    t.integer "tag_ids", default: [], array: true
    t.integer "updater_id"
    t.integer "creator_id"
    t.index ["code"], name: "index_items_on_code", unique: true
    t.index ["creator_id"], name: "index_items_on_creator_id"
    t.index ["unit_id"], name: "index_items_on_unit_id"
    t.index ["updater_id"], name: "index_items_on_updater_id"
  end

  create_table "links", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.bigint "user_id", null: false
    t.string "settings"
    t.boolean "creator", default: false, null: false
    t.boolean "master_account", default: false, null: false
    t.string "role", limit: 50, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "api_token"
    t.index ["api_token"], name: "index_links_on_api_token", unique: true
    t.index ["organisation_id"], name: "index_links_on_organisation_id"
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "loans", force: :cascade do |t|
    t.string "bank_name", null: false, comment: "銀行名+支店名"
    t.decimal "interest_rate", precision: 7, scale: 4, null: false, comment: "percent"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movement_details", force: :cascade do |t|
    t.integer "account_id"
    t.integer "item_id"
    t.decimal "quantity", precision: 14, scale: 2, default: "0.0"
    t.decimal "price", precision: 14, scale: 2, default: "0.0"
    t.string "description"
    t.decimal "discount", precision: 14, scale: 2, default: "0.0"
    t.decimal "balance", precision: 14, scale: 2, default: "0.0"
    t.decimal "original_price", precision: 14, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["account_id"], name: "index_movement_details_on_account_id"
    t.index ["item_id"], name: "index_movement_details_on_item_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "address"
    t.string "address_alt"
    t.string "phone", limit: 40
    t.string "phone_alt", limit: 40
    t.string "mobile", limit: 40
    t.string "email"
    t.string "website"
    t.date "due_date"
    t.text "preferences"
    t.string "time_zone", limit: 100
    t.string "tenant", limit: 50, null: false
    t.string "currency", limit: 3, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "country_code", limit: 2, null: false
    t.boolean "inventory_active", default: true
    t.text "settings"
    t.date "due_on"
    t.string "plan", default: "2users"
    t.index ["tenant"], name: "index_organisations_on_tenant", unique: true
  end

  create_table "other_accounts", force: :cascade do |t|
    t.boolean "inventory", null: false
    t.string "subtype", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.date "date_start"
    t.date "date_end"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["active"], name: "index_projects_on_active"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "store_id"
    t.integer "item_id"
    t.decimal "unitary_cost", precision: 14, scale: 2, default: "0.0"
    t.decimal "quantity", precision: 14, scale: 2, default: "0.0"
    t.decimal "minimum", precision: 14, scale: 2, default: "0.0"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: true
    t.index ["active"], name: "index_stocks_on_active"
    t.index ["item_id"], name: "index_stocks_on_item_id"
    t.index ["minimum"], name: "index_stocks_on_minimum"
    t.index ["quantity"], name: "index_stocks_on_quantity"
    t.index ["store_id"], name: "index_stocks_on_store_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone", limit: 40
    t.boolean "active", default: true, null: false
    t.string "description", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tag_groups", force: :cascade do |t|
    t.string "name"
    t.string "bgcolor"
    t.integer "tag_ids", default: [], array: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_tag_groups_on_name", unique: true
    t.index ["tag_ids"], name: "index_tag_groups_on_tag_ids"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "bgcolor", limit: 10
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "abreviation", limit: 20
    t.decimal "percentage", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "symbol", limit: 20
    t.boolean "integer", default: false
    t.boolean "visible", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", limit: 80, null: false
    t.string "last_name", limit: 80, null: false
    t.string "phone", limit: 40
    t.string "mobile", limit: 40
    t.string "website", limit: 200
    t.string "description", limit: 255
    t.string "crypted_password"
    t.string "salt"
    t.string "confirmation_token", limit: 60
    t.datetime "confirmation_sent_at", precision: nil
    t.datetime "confirmed_at", precision: nil
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "reseted_password_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "last_sign_in_at", precision: nil
    t.boolean "change_default_password", default: false
    t.string "address"
    t.boolean "active", default: true, null: false
    t.string "auth_token"
    t.string "rol", limit: 50
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "old_emails", default: [], array: true
    t.string "locale", default: "en"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contact_accounts", "contacts"
  add_foreign_key "items", "units"
  add_foreign_key "links", "organisations"
  add_foreign_key "links", "users"
end
