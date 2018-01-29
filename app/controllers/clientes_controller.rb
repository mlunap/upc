class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.joins("inner join estados as es on clientes.estado = es.codigo").select("clientes.*, es.descripcion");
    #@clientes = Cliente.all
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
    @estados = Estado.all
  end

  # GET /clientes/1/edit
  def edit
    @estados = Estado.all
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.usuario_creacion = usuario_actual.usuario
    @cliente.fecha_creacion = Time.now
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to clientes_url, notice: 'Datos de cliente registrado correctamente.' }
        #format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        #format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      @cliente.usuario_modificacion = usuario_actual.usuario
      @cliente.fecha_modificacion = Time.now
      if @cliente.update(cliente_params)
        format.html { redirect_to clientes_url, notice: 'Datos de cliente actualizado correctamente.' }
        #format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        #format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: 'Datos de cliente actualizado correctamente.' }
      ormat.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:ruc, :razon_social, :direccion, :telefono, :estado, :usuario_creacion, :fecha_creacion, :usuario_modificacion, :fecha_modificacion)
    end
end
