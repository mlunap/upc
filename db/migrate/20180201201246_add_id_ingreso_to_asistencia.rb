class AddIdIngresoToAsistencia < ActiveRecord::Migration[5.1]
  def change
    add_column :asistencia, :id_ingreso, :integer
  end
end
