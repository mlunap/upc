class MapaController < ApplicationController
  include ApplicationHelper
  before_action :set_menu
  def index
    if params[:fecha].nil?
      @fil_fecha = Date.today.to_s
    else
      @fil_fecha = params[:fecha]
    end
    if params[:salida].nil?
      @ver_salida = false
    else
      @ver_salida = params[:salida]
    end
    data = ""
    if params[:empleado].nil? or params[:empleado] == "0"
      @empleado_id = 0
    else
      @empleado_id = params[:empleado]
      data = "emp.id = " + @empleado_id
    end
    @empleados = Empleado.from("(select 0 as id, '--Todos--' as nombres union select id, nombres ||' ' || apellidos as nombres from empleados) as empleados")
    @asistencia = Asistencium.joins("left join asistencia as sal on asistencia.id=sal.id_ingreso inner join clientes cli on cli.id = asistencia.cliente_id inner join empleados emp on emp.id = asistencia.empleado_id ").where(tipo_asistencia: "ING", :fecha_asistencia=>@fil_fecha..(DateTime.parse(@fil_fecha) + 1.days)).where(data).select("asistencia.*,sal.fecha_asistencia as fecha_salida, sal.latitud as latitud_salida, sal.longitud as longitud_salida").sort_by {|o| -o[:id]}

    @total_puntuales = 0
    @total_tardes = 0
    @total_horas_tardes = 0
    @asistencia.each{|x|
      horas_aux = horas_tardanza(Time.parse(x.empleado.hora_ingreso), Time.parse(x.fecha_asistencia.strftime("%H:%M")))
      if(horas_aux <= 0)
        @total_puntuales += 1
      else
        @total_tardes += 1
        @total_horas_tardes += horas_aux
      end
    }
    @total_empleados = @empleados.count - 1
    @total_pendientes = @total_empleados - (@total_puntuales + @total_tardes)
  end

  private
  def set_menu
    @id_menu="mn_vista"
  end
end
