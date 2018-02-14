class AsistenciaController < ApplicationController
  before_action :set_asistencium, only: [:show, :edit, :update, :destroy]
  before_action :set_menu
  before_action :validad_inicio_sesion
  # GET /asistencia
  # GET /asistencia.json
  def index
    @asistencia = Asistencium.joins("left join asistencia as sal on asistencia.id=sal.id_ingreso").where(empleado_id: usuario_actual.id, tipo_asistencia: "ING", :fecha_asistencia=>Date.today.at_beginning_of_month.to_s..(Date.today+ 1.days).to_s).select("asistencia.*,sal.fecha_asistencia as fecha_salida").sort_by {|o| -o[:id]}
    @asistencium = Asistencium.new
    @asistencium.tipo_asistencia = "ING"
    @asistencia.each{|x|
      if x.fecha_asistencia.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d") then
        if x.fecha_salida.nil? then
          @asistencium.tipo_asistencia = "SAL"
          @asistencium.id_ingreso = x.id
        else
          @asistencium.tipo_asistencia = "FIN"
        end
      end
    }
  end

  # GET /asistencia/1
  # GET /asistencia/1.json
  def show
  end

  # GET /asistencia/new
  def new
    @asistencium = Asistencium.new
  end

  # GET /asistencia/1/edit
  def edit
  end

  # POST /asistencia
  # POST /asistencia.json
  def create
    @asistencium = Asistencium.new(asistencium_params)
    @asistencium.ip_conexion = request.remote_ip
    @asistencium.cliente_id = usuario_actual.cliente_id
    @asistencium.empleado_id = usuario_actual.id
    @asistencium.fecha_asistencia = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      if @asistencium.save
        format.html { redirect_to asistencia_path, notice: 'Asistencia registrada correctamente.' }
        #format.json { render :show, status: :created, location: @asistencium }
      else
        format.html { render :new }
        format.json { render json: @asistencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asistencia/1
  # PATCH/PUT /asistencia/1.json
  def update
    respond_to do |format|
      if @asistencium.update(asistencium_params)
        format.html { redirect_to @asistencium, notice: 'Asistencium was successfully updated.' }
        format.json { render :show, status: :ok, location: @asistencium }
      else
        format.html { render :edit }
        format.json { render json: @asistencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencia/1
  # DELETE /asistencia/1.json
  def destroy
    @asistencium.destroy
    respond_to do |format|
      format.html { redirect_to asistencia_url, notice: 'Asistencium was successfully destroyed.' }
      format.json { head :no_content }
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
