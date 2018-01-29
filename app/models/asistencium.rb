class Asistencium < ApplicationRecord
  belongs_to :empleado
  belongs_to :cliente
end
