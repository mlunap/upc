module SeguridadHelper

  def iniciar_sesion(usuario)
    session[:usuario] = usuario
  end

  def usuario_actual
    @usuario_actual ||= Empleado.new(session[:usuario])
  end

  def usuario_logeado?
    (!usuario_actual.nil? and !usuario_actual.id.nil?)
  end

  def cerrar_sesion
    session.delete(:usuario)
    @usuario_actual = nil
  end

end
