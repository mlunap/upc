class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.string :ruc
      t.string :razon_social
      t.string :direccion
      t.string :telefono
      t.string :estado
      t.string :usuario_creacion
      t.datetime :fecha_creacion
      t.string :usuario_modificacion
      t.datetime :fecha_modificacion

      t.timestamps
    end
  end
end
