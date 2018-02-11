class SeguridadController < ApplicationController
  include ApplicationHelper
  layout "seguridad"
  def index
    @titulo = 'Acceso al Sistema'
  end

  def acceder
    empleado = Empleado.find_by(usuario:params[:usuario][:usuario].downcase)
    @foto = empleado.foto
    empleado.foto = nil
    if !empleado.nil? then
      if empleado.password == params[:usuario][:password] then
        iniciar_sesion empleado
        #validamos el primer ingreso
        if !empleado.usuario_modificacion.nil? then
          if empleado.tipo_usuario == "ADM" then
            redirect_to home_url
          else
            redirect_to asistencia_url
          end
        else
          @titulo = 'Cambio de Contraseña'
          @show_cerrar = false
          #redirect_to login_edit_url
          render 'edit'
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

  def edit
    @foto =foto_perfil_login
    @titulo = 'Cambio de Contraseña'
  end

  # PATCH/PUT /usuario/1
  # PATCH/PUT /usuario/1.json
  def update
    @titulo = 'Cambio de Contraseña'
    usuario = Empleado.find(usuario_actual.id)
    if usuario.password == params[:usuario][:password_actual] then
      if usuario.password != params[:usuario][:password_nuevo] then
        if params[:usuario][:password_nuevo] == params[:usuario][:password_confirmado] then
          if usuario.update_attributes(:foto=>params[:usuario][:foto], :password=>params[:usuario][:password_nuevo], :usuario_modificacion => usuario_actual.usuario, :fecha_modificacion => Time.now) then
            if usuario.tipo_usuario == "ADM" then
              redirect_to home_url
            else
              redirect_to asistencia_url
            end
          else
            flash.now[:danger] = 'Ocurrio un error al actualizar la contraseña.'
            render :edit
          end
        else
          flash.now[:danger] = 'No coincide la nueva contraseña.'
          render :edit
        end
      else
        flash.now[:danger] = 'La nueva contraseña es igual a la actual.'
        render :edit
      end
    else
      flash.now[:danger] = 'Contraseña actual incorrecta.'
      render :edit
    end
  end

  def destroy
    cerrar_sesion
    redirect_to login_path
  end

  def usuario_params
    params.require(:usuario).permit(:dni, :nombres, :apellidos, :correo, :usuario, :password, :tipo_usuario, :hora_ingreso, :hora_salida, :estado, :foto, :usuario_creacion, :fecha_creacion, :usuario_modificacion, :fecha_modificacion, :cliente_id)
  end
end