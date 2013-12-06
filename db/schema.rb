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

ActiveRecord::Schema.define(version: 20131203203250) do

  create_table "cierre_cajas", force: true do |t|
    t.date     "fecha",                         null: false
    t.float    "total_ingreso_externo",         null: false
    t.float    "total_ingreso_hospitalizacion", null: false
    t.integer  "nuemero_total_facturas",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clientes", force: true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "numero_de_identificacion"
    t.string   "telefono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas", force: true do |t|
    t.integer  "numero",               null: false
    t.string   "observacion"
    t.datetime "fecha_de_emision",     null: false
    t.datetime "fecha_de_vencimiento", null: false
    t.float    "subtotal_0",           null: false
    t.float    "subtotal_12",          null: false
    t.float    "descuento",            null: false
    t.float    "iva",                  null: false
    t.float    "total",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cliente_id",           null: false
  end

  create_table "item_facturas", force: true do |t|
    t.integer  "cantidad",       null: false
    t.float    "valor_unitario", null: false
    t.float    "descuento"
    t.float    "iva",            null: false
    t.float    "total",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "producto_id",    null: false
    t.integer  "factura_id",     null: false
  end

  create_table "item_proformas", force: true do |t|
    t.integer  "itemFactura_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kardexes", force: true do |t|
    t.date     "fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "producto_id", null: false
  end

  create_table "lineakardexes", force: true do |t|
    t.string   "tipo",       null: false
    t.date     "fecha",      null: false
    t.float    "cantidad",   null: false
    t.float    "v_unitario", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kardex_id",  null: false
  end

  create_table "pacientes", force: true do |t|
    t.integer  "n_hclinica"
    t.date     "fecha_de_ingreso"
    t.string   "pertenece"
    t.string   "sexo"
    t.date     "fecha_de_nacimiento"
    t.string   "estado_civil"
    t.string   "grado"
    t.string   "familiar"
    t.string   "brigada"
    t.string   "tipo_de_paciente"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "hora_de_ingreso"
    t.integer  "cliente_id",          null: false
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

  create_table "proformas", force: true do |t|
    t.date     "fecha_emision", null: false
    t.integer  "numero",        null: false
    t.float    "iva",           null: false
    t.float    "subtotal_0",    null: false
    t.float    "subtotal_12",   null: false
    t.float    "descuento",     null: false
    t.float    "total",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proveedors", force: true do |t|
    t.string   "nombre_o_razon_social",    null: false
    t.string   "codigo",                   null: false
    t.string   "direccion"
    t.string   "telefono"
    t.string   "ciudad"
    t.string   "numero_de_identificacion", null: false
    t.string   "pais"
    t.string   "representante_legal"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cliente_id"
    t.string   "rol",              null: false
  end

end
