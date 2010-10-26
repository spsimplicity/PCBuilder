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

ActiveRecord::Schema.define(:version => 20100926010319) do

  create_table "case_motherboards", :force => true do |t|
    t.integer  "case_id",                  :null => false
    t.string   "size",       :limit => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_motherboards", ["case_id"], :name => "fkToCaseID"

  create_table "cases", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 5,  :null => false
    t.string   "manufacturer",        :limit => 20, :null => false
    t.integer  "price",                             :null => false
    t.string   "model",               :limit => 30, :null => false
    t.string   "series",              :limit => 30
    t.string   "manufacturerwebsite",               :null => false
    t.string   "googleprice",                       :null => false
    t.integer  "totalbays",                         :null => false
    t.integer  "hddbays",                           :null => false
    t.integer  "conversionbays",                    :null => false
    t.integer  "ssdbays",                           :null => false
    t.integer  "expansionslots",                    :null => false
    t.integer  "discbays",                          :null => false
    t.string   "casetype",            :limit => 25, :null => false
    t.integer  "length",                            :null => false
    t.integer  "width",                             :null => false
    t.integer  "height",                            :null => false
    t.integer  "maxcoolerheight",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cases", ["part_id"], :name => "fkCaseIdToPart"

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

  add_index "computers", ["case_id"], :name => "fkToCaseFromCompID"
  add_index "computers", ["cpu_cooler_id"], :name => "fkToCpuCoolerFromCompID"
  add_index "computers", ["cpu_id"], :name => "fkToCpuFromCompID"
  add_index "computers", ["motherboard_id"], :name => "fkToMoboFromCompID"
  add_index "computers", ["power_supply_id"], :name => "fkToPsuFromCompID"
  add_index "computers", ["user_id"], :name => "fkToUserFromCompID"

  create_table "cpu_cooler_sockets", :force => true do |t|
    t.integer  "cpu_cooler_id",               :null => false
    t.string   "sockettype",    :limit => 10, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cpu_cooler_sockets", ["cpu_cooler_id"], :name => "fkToCpuCoolerID"

  create_table "cpu_coolers", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 15, :null => false
    t.string   "model",               :limit => 30, :null => false
    t.string   "manufacturer",        :limit => 20, :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.integer  "price",                             :null => false
    t.string   "googleprice",                       :null => false
    t.integer  "maxmemheight"
    t.float    "height",                            :null => false
    t.float    "width",                             :null => false
    t.float    "length",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cpu_coolers", ["part_id"], :name => "fkCpuCoolerIdToPart"

  create_table "cpus", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 10, :null => false
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
    t.integer  "maxmemory"
    t.integer  "memchanneltype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cpus", ["part_id"], :name => "fkCpuIdToPart"

  create_table "disc_drives", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 10, :null => false
    t.string   "manufacturer",        :limit => 30, :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.integer  "price",                             :null => false
    t.string   "googleprice",                       :null => false
    t.string   "model",               :limit => 20, :null => false
    t.string   "interface",           :limit => 10, :null => false
    t.integer  "cache"
    t.string   "drivetype",           :limit => 15, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disc_drives", ["part_id"], :name => "fkDdToPart"

  create_table "displays", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 10, :null => false
    t.string   "manufacturer",        :limit => 20, :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.integer  "price",                             :null => false
    t.string   "googleprice",                       :null => false
    t.string   "model",               :limit => 30, :null => false
    t.string   "contrastratio",       :limit => 15, :null => false
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.string   "resolution",          :limit => 15, :null => false
    t.string   "monitortype",         :limit => 5,  :null => false
    t.integer  "screensize",                        :null => false
    t.boolean  "widescreen",                        :null => false
    t.float    "displaycolors"
    t.integer  "vga",                               :null => false
    t.integer  "hdmi",                              :null => false
    t.integer  "svideo",                            :null => false
    t.integer  "dvi",                               :null => false
    t.integer  "displayport",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "displays", ["part_id"], :name => "fkDisToPart"

  create_table "graphics_cards", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 15, :null => false
    t.string   "manufacturer",        :limit => 20, :null => false
    t.string   "chipmanufacturer",    :limit => 10, :null => false
    t.integer  "price",                             :null => false
    t.string   "model",               :limit => 50, :null => false
    t.string   "series",              :limit => 30
    t.integer  "coreclock",                         :null => false
    t.integer  "shaderclock"
    t.integer  "memoryclock",                       :null => false
    t.integer  "memorysize",                        :null => false
    t.string   "memorytype",          :limit => 5,  :null => false
    t.integer  "directx",                           :null => false
    t.string   "width",               :limit => 10, :null => false
    t.integer  "length",                            :null => false
    t.string   "interface",           :limit => 15, :null => false
    t.string   "gpu",                 :limit => 10, :null => false
    t.boolean  "multigpusupport",                   :null => false
    t.string   "maxresolution",       :limit => 10, :null => false
    t.integer  "hdmi",                              :null => false
    t.integer  "dvi",                               :null => false
    t.integer  "displayport",                       :null => false
    t.integer  "vga",                               :null => false
    t.integer  "svideo",                            :null => false
    t.integer  "minpower",                          :null => false
    t.integer  "multigpupower"
    t.integer  "power6pin",                         :null => false
    t.integer  "power8pin",                         :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.string   "googleprice",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "graphics_cards", ["part_id"], :name => "fkGcToPart"

  create_table "hard_drives", :force => true do |t|
    t.integer  "part_id",             :null => false
    t.string   "parttype",            :null => false
    t.string   "manufacturer",        :null => false
    t.string   "manufacturerwebsite", :null => false
    t.string   "googleprice",         :null => false
    t.string   "model",               :null => false
    t.string   "series"
    t.integer  "price",               :null => false
    t.string   "interface",           :null => false
    t.integer  "capacity",            :null => false
    t.integer  "rpm",                 :null => false
    t.integer  "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hard_drives", ["part_id"], :name => "fkHddToPart"

  create_table "has_parts", :force => true do |t|
    t.integer  "computer_id",               :null => false
    t.integer  "part_id",                   :null => false
    t.string   "parttype",    :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "has_parts", ["computer_id"], :name => "fkComputer"
  add_index "has_parts", ["part_id"], :name => "fkPart_Parttype"

  create_table "incompatibles", :force => true do |t|
    t.integer  "part1_id",                 :null => false
    t.string   "part1type",  :limit => 20, :null => false
    t.integer  "part2_id",                 :null => false
    t.string   "part2type",  :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incompatibles", ["part1_id"], :name => "fkPart1"
  add_index "incompatibles", ["part2_id"], :name => "fkPart2"

  create_table "memories", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 10, :null => false
    t.string   "manufacturer",        :limit => 20, :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.integer  "price",                             :null => false
    t.string   "googleprice",                       :null => false
    t.string   "model",               :limit => 30, :null => false
    t.string   "series",              :limit => 30
    t.integer  "speed",                             :null => false
    t.string   "timings",             :limit => 15, :null => false
    t.integer  "capacity",                          :null => false
    t.integer  "multichanneltype",                  :null => false
    t.string   "memorytype",          :limit => 5,  :null => false
    t.integer  "pinnumber",                         :null => false
    t.integer  "dimms",                             :null => false
    t.integer  "totalcapacity",                     :null => false
    t.float    "voltage",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memories", ["part_id"], :name => "fkMemToPart"

  create_table "memory_speeds", :force => true do |t|
    t.integer  "motherboard_id", :null => false
    t.integer  "speed",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memory_speeds", ["motherboard_id"], :name => "fkToMoboID"

  create_table "motherboards", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 15, :null => false
    t.string   "manufacturer",        :limit => 15, :null => false
    t.string   "model",               :limit => 40, :null => false
    t.integer  "price",                             :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.string   "googleprice",                       :null => false
    t.integer  "maxmemory",                         :null => false
    t.string   "memorytype",          :limit => 5,  :null => false
    t.integer  "memchannel",                        :null => false
    t.integer  "pci_ex16",                          :null => false
    t.integer  "pci_e2",                            :null => false
    t.integer  "memoryslots",                       :null => false
    t.string   "size",                :limit => 15, :null => false
    t.integer  "cpupowerpin",                       :null => false
    t.integer  "fsb",                               :null => false
    t.string   "northbridge",         :limit => 25, :null => false
    t.string   "southbridge",         :limit => 25
    t.integer  "mainpower",                         :null => false
    t.integer  "pci_e",                             :null => false
    t.integer  "pci",                               :null => false
    t.boolean  "crossfire",                         :null => false
    t.boolean  "sli",                               :null => false
    t.string   "sockettype",          :limit => 10, :null => false
    t.integer  "sata3",                             :null => false
    t.integer  "sata6",                             :null => false
    t.integer  "ide",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "motherboards", ["part_id"], :name => "fkMotherboarIdToPart"

  create_table "parts", :force => true do |t|
    t.string   "parttype",   :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "power_supplies", :force => true do |t|
    t.integer  "part_id",                           :null => false
    t.string   "parttype",            :limit => 20, :null => false
    t.string   "manufacturer",        :limit => 30, :null => false
    t.string   "manufacturerwebsite",               :null => false
    t.string   "googleprice",                       :null => false
    t.integer  "price",                             :null => false
    t.string   "model",               :limit => 30, :null => false
    t.string   "series",              :limit => 30, :null => false
    t.integer  "fansize",                           :null => false
    t.integer  "mainpower",                         :null => false
    t.integer  "satapower",                         :null => false
    t.boolean  "multi_gpu",                         :null => false
    t.integer  "peripheral",                        :null => false
    t.string   "energycert",          :limit => 20
    t.string   "power_supply_type",   :limit => 40, :null => false
    t.integer  "poweroutput",                       :null => false
    t.integer  "cpu4_4pin",                         :null => false
    t.integer  "cpu4pin",                           :null => false
    t.integer  "cpu8pin",                           :null => false
    t.integer  "gpu8pin",                           :null => false
    t.integer  "gpu6pin",                           :null => false
    t.integer  "gpu6_2pin",                         :null => false
    t.integer  "length",                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "power_supplies", ["part_id"], :name => "fkPowerSupplyIdToPart"

  create_table "read_speeds", :force => true do |t|
    t.integer  "disc_drife_id",               :null => false
    t.string   "readtype",      :limit => 15, :null => false
    t.integer  "speed",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "read_speeds", ["disc_drife_id"], :name => "fkRSpeedToDd"

  create_table "users", :force => true do |t|
    t.string   "name",               :limit => 30,  :null => false
    t.string   "email",              :limit => 50,  :null => false
    t.string   "encrypted_password", :limit => 150
    t.string   "salt",               :limit => 150
    t.string   "ip",                 :limit => 30,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "write_speeds", :force => true do |t|
    t.integer  "disc_drife_id",               :null => false
    t.string   "writetype",     :limit => 15, :null => false
    t.integer  "speed",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "write_speeds", ["disc_drife_id"], :name => "fkWSpeedToDd"

end
