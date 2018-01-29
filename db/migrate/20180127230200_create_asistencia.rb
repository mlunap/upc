class CreateAsistencia < ActiveRecord::Migration[5.1]
  def change
    create_table :asistencia do |t|
      t.references :empleado, foreign_key: true
      t.references :cliente, foreign_key: true
      t.string :tipo_asistencia
      t.datetime :fecha_asistencia
      t.string :ip_conexion
      t.string :latitud
      t.string :longitud

      t.timestamps
    end
  end
end
