class AddClienteToEmpleados < ActiveRecord::Migration[5.1]
  def change
    add_reference :empleados, :cliente, foreign_key: true
  end
end
