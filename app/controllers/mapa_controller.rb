class MapaController < ApplicationController
  include ApplicationHelper
  before_action :set_menu
  before_action :validad_inicio_sesion
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

    data = "1 = 1"
    if params[:cliente].nil? or params[:cliente] == "0"
      @cliente_id = 0
    else
      @cliente_id = params[:cliente]
      data = "asistencia.cliente_id = " + @cliente_id
    end

    if params[:empleado].nil? or (params[:empleado].size == 1 and  params[:empleado].include? "0")
      @empleado_id = 0
    else
      if !params[:empleado].include? "0"
        @empleado_id = params[:empleado]
        data += " and empleados.id in (" + @empleado_id.join(",") + ")"
      end
    end

    @clientes = Cliente.from("(select 0 as id, '--Todos--' as nombres union select id, razon_social as nombres from clientes) as clientes")
    @empleados = Empleado.from("(select 0 as id, '--Todos--' as nombres union select id, nombres ||' ' || apellidos as nombres from empleados where "+ (@cliente_id.to_s == "0" ? " 1= 1" : ("cliente_id = " +@cliente_id.to_s)) +") as empleados")
    @asistencia = Asistencium.joins("left join asistencia as sal on asistencia.id=sal.id_ingreso
      inner join clientes cli on cli.id = asistencia.cliente_id inner join empleados on empleados.id = asistencia.empleado_id ")
                      .where(tipo_asistencia: "ING", :fecha_asistencia=>@fil_fecha..(DateTime.parse(@fil_fecha) + 1.days)).where(data)
                      .select("asistencia.*,sal.fecha_asistencia as fecha_salida, sal.latitud as latitud_salida, sal.longitud as longitud_salida").sort_by {|o| -o[:id]}

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
    @total_horas_tardes = @total_horas_tardes.round(2)
    @total_empleados = @empleados.count - 1
    @total_pendientes = @total_empleados - (@total_puntuales + @total_tardes)
  end

  def listar_empleado
    filtro = "1 = 1"
    if !params[:idCliente].nil? and params[:idCliente] != "0"
      filtro ="cliente_id = " + params[:idCliente]
    end
    @empleadosfiltro = Empleado.from("(select 0 as id, '--Todos--' as nombres union select id, nombres ||' ' || apellidos as nombres from empleados where "+ filtro +") as empleados")
    render json: @empleadosfiltro
  end

  private
  def set_menu
    @id_menu="mn_vista"
  end
end
