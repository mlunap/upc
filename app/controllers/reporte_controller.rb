class ReporteController < ApplicationController
  require 'will_paginate/array'
  before_action :set_menu
  before_action :validad_inicio_sesion

  def index
    @fil_data=""
    if params[:fecha_ini].nil?
      @fil_fecha_fin = Date.today.to_s
      @fil_fecha_ini = (Date.today - 1.month).to_s
    else
      @fil_fecha_fin = params[:fecha_fin]
      @fil_fecha_ini = params[:fecha_ini]
    end

    if !params[:datos].nil? and params[:datos] != "" then
      @fil_data= params[:datos]
    end
    @asistencia = ejectutar_consulta(@fil_fecha_ini, @fil_fecha_fin, @fil_data, true)
  end

  def excel
    if params[:fecha_ini].nil? then
      fecha_fin = Date.today.to_s
      fecha_ini = (Date.today - 1.month).to_s
    else
      fecha_fin = params[:fecha_fin]
      fecha_ini = params[:fecha_ini]
    end
    @asistencia = ejectutar_consulta(fecha_ini, fecha_fin, params[:datos], false)
    respond_to do |format|
      format.xls
    end
  end

  private
  def ejectutar_consulta(fecha_ini, fecha_fin, filtro, flag_paginar)
    data = ""
    if !filtro.nil? and filtro != "" then
      data = "razon_social like '%#{filtro}%' or dni like '%#{filtro}%' or nombres like '%#{filtro}%' or apellidos like '%#{filtro}%'"
    end
    if flag_paginar then
      return Asistencium.joins("left join asistencia as sal on asistencia.id=sal.id_ingreso inner join clientes cli on cli.id = asistencia.cliente_id inner join empleados emp on emp.id = asistencia.empleado_id ").where(tipo_asistencia: "ING", :fecha_asistencia=>fecha_ini..(DateTime.parse(fecha_fin) + 1.days)).where(data).select("asistencia.*,sal.fecha_asistencia as fecha_salida, sal.latitud as latitud_salida, sal.longitud as longitud_salida").sort_by {|o| -o[:id]}.paginate(:page => params[:page], :per_page => 10)
    else
      return Asistencium.joins("left join asistencia as sal on asistencia.id=sal.id_ingreso inner join clientes cli on cli.id = asistencia.cliente_id inner join empleados emp on emp.id = asistencia.empleado_id ").where(tipo_asistencia: "ING", :fecha_asistencia=>fecha_ini..(DateTime.parse(fecha_fin) + 1.days)).where(data).select("asistencia.*,sal.fecha_asistencia as fecha_salida, sal.latitud as latitud_salida, sal.longitud as longitud_salida, sal.ip_conexion as ip_salida").sort_by {|o| -o[:id]}
    end
  end

  def set_menu
    @id_menu="mn_reporte"
  end
end
