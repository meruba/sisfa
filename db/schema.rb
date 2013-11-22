# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131121165947) do

  create_table "facturas", force: true do |t|
    t.integer  "numero",               null: false
    t.string   "observacion"
    t.datetime "fecha_de_emision",     null: false
    t.datetime "fecha_de_vencimiento", null: false
    t.float    "subtotal",             null: false
    t.float    "descuento",            null: false
    t.float    "iva",                  null: false
    t.float    "total",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "persona_id",           null: false
    t.integer  "producto_id",          null: false
  end

  create_table "item_facturas", force: true do |t|
    t.integer  "cantidad",       null: false
    t.float    "valor_unitario", null: false
    t.float    "descuento"
    t.float    "iva",            null: false
    t.float    "total",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", force: true do |t|
    t.string "nombre",             null: false
    t.float  "precio",             null: false
    t.string "codigo"
    t.string "categoria"
    t.string "descripcion"
    t.date   "fecha_de_caducidad"
    t.string "casa_comercial"
  end

end
