module ApplicationHelper
  def obtener_tipo_alerta_bootstrap(tipo)
    case tipo
      when 'success'
        "alert-success"
      when 'error'
        "alert-error"
      when 'danger'
        "alert-danger"
      when 'alert'
        "alert-block"
      when 'notice'
        "alert-info"
      else
        tipo.to_s
    end
  end
end
