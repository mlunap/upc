class EmpleadosController < ApplicationController
  before_action :set_empleado, only: [:show, :edit, :update, :destroy]

  # GET /empleados
  # GET /empleados.json
  def index
    #@empleados = Empleado.all
    @empleados = Empleado.joins("inner join estados as es on empleados.estado = es.codigo inner join clientes cl on empleados.cliente_id = cl.id").select("empleados.*, es.descripcion, cl.razon_social");
  end

  # GET /empleados/1
  # GET /empleados/1.json
  def show

  end

  # GET /empleados/new
  def new
    @empleado = Empleado.new
    @clientes = Cliente.all
    @tipos_usuario = Perfil.all
    @estados = Estado.all
  end

  # GET /empleados/1/edit
  def edit
    @clientes = Cliente.all
    @tipos_usuario = Perfil.all
    @estados = Estado.all
  end

  # POST /empleados
  # POST /empleados.json
  def create
    @empleado = Empleado.new(empleado_params)
    respond_to do |format|
      @empleado.usuario = @empleado.correo.split('@')[0].downcase
      @empleado.password = @empleado.nombres[0]+@empleado.apellidos[0]+@empleado.dni[0..3]
      @empleado.usuario_creacion = usuario_actual.usuario
      @empleado.fecha_creacion = Time.now
      if @empleado.save
        HelperMailer.enviar_email(@empleado, 'Credenciales de Acceso al Sistema').deliver
        format.html { redirect_to empleados_url, notice: 'Datos de empleado registrado correctamente.' }
        #format.html { redirect_to @empleado, notice: 'Datos de empleado registrado correctamente.' }
        #format.json { render :show, status: :created, location: @empleado }
      else
        format.html { render :new }
        format.json { render json: @empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empleados/1
  # PATCH/PUT /empleados/1.json
  def update
    respond_to do |format|
      @empleado.usuario_modificacion = usuario_actual.usuario
      @empleado.fecha_modificacion = Time.now
      if @empleado.update(empleado_params)
        format.html { redirect_to empleados_url, notice: 'Datos de empleado actualizado correctamente.' }
        #format.html { redirect_to @empleado, notice: 'Datos de empleado actualizado correctamente.' }
        #format.json { render :show, status: :ok, location: @empleado }
      else
        format.html { render :edit }
        format.json { render json: @empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empleados/1
  # DELETE /empleados/1.json
  def destroy
    @empleado.destroy
    respond_to do |format|
      format.html { redirect_to empleados_url, notice: 'Datos de empleado eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empleado
      @empleado = Empleado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empleado_params
      params.require(:empleado).permit(:dni, :nombres, :apellidos, :correo, :usuario, :password, :tipo_usuario, :hora_ingreso, :hora_salida, :estado, :foto, :usuario_creacion, :fecha_creacion, :usuario_modificacion, :fecha_modificacion, :cliente_id)
    end
end
