
class FiltroReporte
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  attr_accessor :datos, :fecha_ini, :fecha_fin
end