class CreateEstados < ActiveRecord::Migration[5.1]
  def change
    create_table :estados do |t|
      t.string :codigo
      t.string :descripcion
      t.string :usuario_creacion
      t.datetime :fecha_creacion
      t.string :usuario_modificacion
      t.datetime :fecha_modificacion

      t.timestamps
    end
  end
end
