class HomeController < ApplicationController
  def index
    if !usuario_logeado? then
      redirect_to login_path
    else
      @asistencium = Asistencium.new
      if usuario_actual.tipo_usuario == "ADM" then
        @asistencias = Asistencium.joins(" as asi inner join clientes cl on asi.cliente_id = cl.id inner join empleados em on asi.empleado_id = em.id").select("asi.*,strftime('%Y-%m-%d',asi.fecha_asistencia) as fecha_marcada, strftime('%H:%M',asi.fecha_asistencia) as hora_marcada,cl.razon_social,em.nombres, em.apellidos, em.hora_ingreso")
      else
        @asistencias = Asistencium.joins(" as asi inner join clientes cl on asi.cliente_id = cl.id inner join empleados em on asi.empleado_id = em.id where em.id =" + usuario_actual.id.to_s).select("asi.*,strftime('%Y-%m-%d',asi.fecha_asistencia) as fecha_marcada, strftime('%H:%M',asi.fecha_asistencia) as hora_marcada,cl.razon_social,em.nombres, em.apellidos, em.hora_ingreso")
      end
    end

  end

  # POST /asistencia
  # POST /asistencia.json
  def asistencia
    @asistencium = Asistencium.new(asistencium_params)
    @asistencium.ip_conexion = request.remote_ip
    @asistencium.cliente_id = usuario_actual.cliente_id
    @asistencium.empleado_id = usuario_actual.id
    @asistencium.tipo_asistencia = 'ING'
    @asistencium.fecha_asistencia = Time.now
    respond_to do |format|
      if @asistencium.save
        format.html { redirect_to home_url, notice: 'Asistencia registrada correctamente.'}
        format.json { render :index, status: :created, location: @asistencium }
      else
        format.html { render :index }
        format.json { render json: @asistencium.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_asistencium
    @asistencium = Asistencium.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asistencium_params
    params.require(:asistencium).permit(:empleado_id, :cliente_id, :tipo_asistencia, :fecha_asistencia, :ip_conexion, :latitud, :longitud)
  end
end
