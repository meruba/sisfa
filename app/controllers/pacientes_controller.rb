class PacientesController < ApplicationController
	# GET /personas
  # GET /personas.json
  def index
    @pacientes = Paciente.all
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
  end

  # GET /personas/new
  def new
    @paciente = Paciente.new
  end

  # GET /personas/1/edit
  def edit
  end

  # POST /personas
  # POST /personas.json
  def create
    @paciente = Paciente.new(paciente_params)

    respond_to do |format|
      if @paciente.save
        format.html { redirect_to @paciente, notice: 'Paciente Almacenada.' }
        format.json { render action: 'show', status: :created, location: @persona }
      else
        format.html { render action: 'new' }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    respond_to do |format|
      if @paciente.update(paciente_params)
        format.html { redirect_to @paciente, notice: 'Modificacion exitosa.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to pacientes_url }
      format.json { head :no_content }
    end
  end
  
  private 
    def paciente_params
      params.require(:paciente).permit(:n_hclinica, :fecha_de_ingreso, :fecha_de_nacimiento, :hora_de_ingreso, :pertenece, :sexo, :estado_civil, :grado, :familiar, :brigada,
      	:tipo_de_paciente)
    end  
end
