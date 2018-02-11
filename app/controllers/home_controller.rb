class HomeController < ApplicationController
  include ApplicationHelper
  before_action :set_menu

  def index
    if !usuario_logeado? then
      redirect_to login_path
    else
      if usuario_actual.tipo_usuario == "ADM" then
        @total_puntuales = 0
        @total_tardes = 0
        @asistencium = Asistencium.new
        @asistencias = Asistencium.joins(" as asi left join asistencia as sal on asi.id=sal.id_ingreso inner join clientes cl on asi.cliente_id = cl.id inner join empleados em on asi.empleado_id = em.id where asi.tipo_asistencia='ING' and asi.fecha_asistencia >='"+Date.today.to_s+"'").select("asi.*,strftime('%Y-%m-%d',asi.fecha_asistencia) as fecha_marcada, strftime('%H:%M',asi.fecha_asistencia) as hora_marcada,cl.razon_social,em.nombres, em.apellidos, em.hora_ingreso, sal.fecha_asistencia as fecha_salida, ' ' as observacion").sort_by {|o| -o[:id]}
        @asistencium.tipo_asistencia = "ING"
        @asistencias.each{|x|
          if x.fecha_marcada == Time.now.strftime("%Y-%m-%d") and x.empleado_id == usuario_actual.id then
            if x.fecha_salida.nil? then
              @asistencium.tipo_asistencia = "SAL"
              @asistencium.id_ingreso = x.id
            else
              @asistencium.tipo_asistencia = "FIN"
            end
          end
          x.observacion = datos_tardanza(Time.parse(x.hora_ingreso), Time.parse(x.hora_marcada))
          if(x.observacion == "")
            @total_puntuales += 1
          else
            @total_tardes += 1
          end
        }
        @total_empleados = Empleado.where(:estado => 'A').count
        @total_pendientes = @total_empleados - (@total_puntuales + @total_tardes)
      else
        redirect_to asistencia_url
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
    @asistencium.fecha_asistencia = Time.now.strftime("%Y-%m-%d %H:%M:%S")
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
    params.require(:asistencium).permit(:empleado_id, :cliente_id, :tipo_asistencia, :fecha_asistencia, :ip_conexion, :latitud, :longitud, :id_ingreso)
  end

  def set_menu
    @id_menu=""
  end
end
