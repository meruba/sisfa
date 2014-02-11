class RegistrosController < ApplicationController

	def index
		
	end

	def new
		@registro = Registro.new
		@registro.build_cliente
	end

	def create
    # @registro = Registro.new(registro_params)
    cliente_attrs = params[:registro].delete :cliente_attributes
    militar = cliente_attrs.delete :militar
    @cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
    if @cliente.save
      @registro = @cliente.registros.build(registro_params)
      if @registro.save
        redirect_to registros_path, :notice => "Paciente Guardado"
      else
        flash[:error] = "Error"
        redirect_to registros_path
      end
    else
    	flash[:error] = "Error"
      redirect_to registros_path
    end
	end

	private

	def registro_params
    params.require(:registro).permit :n_hclinica, 
    																:fecha_de_ingreso,
    																:fecha_de_salida,
    																:especialidad,
    																:medico_asignado,
    																:cliente_attributes => [
                                      :nombre,
                                      :numero_de_identificacion,
                                      :direccion,
                                      :telefono,
                                      :email,
                                      :created_at,
                                      :updated_at
                                    ]
	end
end
