class CreateEmpleados < ActiveRecord::Migration[5.1]
  def change
    create_table :empleados do |t|
      t.string :dni
      t.string :nombres
      t.string :apellidos
      t.string :correo
      t.string :usuario
      t.string :password
      t.string :tipo_usuario
      t.string :hora_ingreso
      t.string :hora_salida
      t.string :estado
      t.string :foto
      t.string :usuario_creacion
      t.datetime :fecha_creacion
      t.string :usuario_modificacion
      t.datetime :fecha_modificacion

      t.timestamps
    end
  end
end
