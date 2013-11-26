class PersonasController < ApplicationController
	
	# GET /personas
  # GET /personas.json
  def index
    @personas = Persona.all
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
  end

  # GET /personas/new
  def new
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
  end

  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(persona_params)

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, notice: 'Persona Almacenada.' }
        format.json { render action: 'show', status: :created, location: @persona }
      else
        format.html { render action: 'new' }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: 'Modificacion exitosa.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to personas_url }
      format.json { head :no_content }
    end
  end
  
  private 
    def persona_params
      params.require(:persona).permit(:nombre, :direccion, :numero_identificacion, :telefono, :celular, :email, :tipo_de_paciente, :codigo_issfa)
    end
end