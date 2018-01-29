class CreatePerfils < ActiveRecord::Migration[5.1]
  def change
    create_table :perfils do |t|
      t.string :codigo
      t.string :desprincion
      t.string :usuario_creacion
      t.datetime :fecha_creacion
      t.string :usuario_modificacion
      t.datetime :fecha_modificacion

      t.timestamps
    end
  end
end
