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

  def observacion_asistencia(hora_inicio, hora_fin)
    observacion = ""
    min = (hora_fin - hora_inicio)/ 1.minutes
    if min >= 1 then
      if min >= 60 then
        observacion += (min/60).to_i.to_s + " Hora(s) " + (min%60).to_i.to_s + " Minuto(s)"
      else
        observacion += min.to_i.to_s + " Minutos"
      end
      observacion = '<span class="label label-danger">Tarde: '+observacion+'</span>'
    else
      observacion = '<span class="label label-success">Puntual</span>'
    end
    return observacion
  end

  def datos_tardanza(hora_inicio, hora_fin)
    observacion = ""
    min = (hora_fin - hora_inicio)/ 1.minutes
    if min >= 1 then
      if min >= 60 then
        observacion += (min/60).to_i.to_s + " Hora(s) " + (min%60).to_i.to_s + " Minuto(s)"
      else
        observacion += min.to_i.to_s + " Minutos"
      end
    end
    return observacion
  end

  def horas_tardanza(hora_inicio, hora_fin)
    (hora_fin - hora_inicio)/ 1.hours
  end

  def foto_perfil
    foto = Empleado.select("foto").where(id:usuario_actual.id).first.foto
    foto ||= "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAYAAACpSkzOAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAO/wAADv8BxyQWTQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAGwSURBVEiJ5dXPi81RGMfxl1+jMQvEuM2GRpZIEimzUEoWin/B/yDFjp01fwBFiWRjlrKwQTaaSN1hFqYUGTWjafyIxffcOo5zvt9z2fHU0733eT7neT/nued7vvxrtqpSN4lTmEIP67GIt3iG25j/m0ZGcQ3f8aPFV3AFY38CGcGDDkDqMxjPFWsb3VlcTmKfcRevsawZ6WlsizQPcbR+P02xuNv72JrRjeFeoj1ZC9meLFzGlpA7gzeYw/kQ24hPkf5GLehwAnoc4uP4luT2hly8q9m04OoCaDH5vR8f0ceaJDcZPj9EsV5acG0BtCmj25zRLeBR+L4zii8V6v5m07qP8hKOBP0ev470SQ3kUAXkK04E/QReJfmrNaCbFaALQdvDi0z+eA3oouY4t4EmgvZWJjePdTUg2NABmw2+ksldqoUIHQ1zx8W+exgQ+bEM/FjwuSS+MCwE9uF9ATSwmST+tFQsfcpje4cdOJjJjWp2NKX5Pwf2EtdzxUo3w8CeF+LnCvEvpUJtO6LpcETTdU/3q79viJu7ZLs0F2fbiZsuLe4aXWx93MGBDs1/Yj8BGqjGTHeHv7YAAAAASUVORK5CYII="
  end

  def foto_perfil_login
    foto = Empleado.select("foto").where(id:usuario_actual.id).first.foto
    foto ||= foto_defecto
  end

  def foto_defecto
    return "data:image/png;base64,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"
  end

  def descripcion_estado(codigo)
    Estado.find_by(:codigo =>codigo).descripcion
  end

  def razon_social_cliente(id)
    Cliente.find(id).razon_social
  end
end