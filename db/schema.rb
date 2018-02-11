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

ActiveRecord::Schema.define(version: 20180201201246) do

  create_table "asistencia", force: :cascade do |t|
    t.integer "empleado_id"
    t.integer "cliente_id"
    t.string "tipo_asistencia"
    t.datetime "fecha_asistencia"
    t.string "ip_conexion"
    t.string "latitud"
    t.string "longitud"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "id_ingreso"
    t.index ["cliente_id"], name: "index_asistencia_on_cliente_id"
    t.index ["empleado_id"], name: "index_asistencia_on_empleado_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.string "ruc"
    t.string "razon_social"
    t.string "direccion"
    t.string "telefono"
    t.string "estado"
    t.string "usuario_creacion"
    t.datetime "fecha_creacion"
    t.string "usuario_modificacion"
    t.datetime "fecha_modificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empleados", force: :cascade do |t|
    t.string "dni"
    t.string "nombres"
    t.string "apellidos"
    t.string "correo"
    t.string "usuario"
    t.string "password"
    t.string "tipo_usuario"
    t.string "hora_ingreso"
    t.string "hora_salida"
    t.string "estado"
    t.string "foto"
    t.string "usuario_creacion"
    t.datetime "fecha_creacion"
    t.string "usuario_modificacion"
    t.datetime "fecha_modificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cliente_id"
    t.index ["cliente_id"], name: "index_empleados_on_cliente_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "codigo"
    t.string "descripcion"
    t.string "usuario_creacion"
    t.datetime "fecha_creacion"
    t.string "usuario_modificacion"
    t.datetime "fecha_modificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfils", force: :cascade do |t|
    t.string "codigo"
    t.string "desprincion"
    t.string "usuario_creacion"
    t.datetime "fecha_creacion"
    t.string "usuario_modificacion"
    t.datetime "fecha_modificacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
