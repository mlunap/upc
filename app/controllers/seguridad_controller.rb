class SeguridadController < ApplicationController
  layout "seguridad"
  def index
  end

  def acceder
    empleado = Empleado.find_by(usuario:params[:usuario][:usuario].downcase)
    if !empleado.nil? then
      if empleado.password == params[:usuario][:password] then
        iniciar_sesion empleado
        if empleado.tipo_usuario == "ADM" then
          redirect_to home_url
        else
          redirect_to asistencia_url
        end
      else
        flash.now[:danger] = 'El Password es incorrecto.'
        render 'index'
      end
    else
      flash.now[:danger] = 'El usuario es inválido.'
      render 'index'
    end
  end

  def destroy
    cerrar_sesion
    redirect_to login_path
  end
end