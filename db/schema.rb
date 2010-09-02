# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100831214703) do

  create_table "computers", :force => true do |t|
    t.string   "name",            :limit => 50, :default => "Custom Built Computer", :null => false
    t.integer  "motherboard_id",                                                     :null => false
    t.integer  "cpu_id",                                                             :null => false
    t.integer  "cpu_cooler_id",                                                      :null => false
    t.integer  "power_supply_id",                                                    :null => false
    t.integer  "case_id",                                                            :null => false
    t.integer  "user_id",                                                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "computers", ["user_id"], :name => "fkToUserID"

  create_table "cpu_coolers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpus", :force => true do |t|
    t.string   "type",                :limit => 10, :null => false
    t.string   "model",               :limit => 10, :null => false
    t.string   "manufacturer",        :limit => 10, :null => false
    t.string   "series",              :limit => 30
    t.integer  "price",                             :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.string   "googleprice",                       :null => false
    t.float    "frequency",                         :null => false
    t.string   "sockettype",          :limit => 15, :null => false
    t.float    "fsb",                               :null => false
    t.integer  "l1cache"
    t.integer  "l2cache"
    t.integer  "l3cache"
    t.integer  "cores",                             :null => false
    t.integer  "watts",                             :null => false
    t.integer  "powerpin",                          :null => false
    t.integer  "maxmemory",                         :null => false
    t.integer  "memchanneltype",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",               :limit => 30,  :null => false
    t.string   "email",              :limit => 50,  :null => false
    t.string   "encrypted_password", :limit => 150
    t.string   "salt",               :limit => 150
    t.string   "ip",                 :limit => 30,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
