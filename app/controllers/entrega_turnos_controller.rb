class EntregaTurnosController < ApplicationController
  before_action :find_entrega, only: [:show]
	def new
		@entrega = EntregaTurno.new
	end

	def create
		@entrega = EntregaTurno.new(entrega_turno_params.merge(fecha: Time.now))
		if @entrega.save
      redirect_to dashboard_enfermeria_index_path, :notice => "guardado"
    else
      redirect_to dashboard_enfermeria_index_path, :notice => "ERRORES"
    end
	end

	def show
		@item = ItemEntregaTurno.new
		# items = @entrega.item_entrega_turnos.includes(hospitalizacion_registro: [:paciente => :cliente])
		items = @entrega.item_entrega_turnos.includes(hospitalizacion_registro: [:paciente => :cliente])
		@examenes = items.where(:tipo_item => "examen")
		@ayunas = items.where(:tipo_item => "ayuna")
		@aislamientos = items.where(:tipo_item => "aislamiento")
		@defunciones = items.where(:tipo_item => "defuncion")
		@movimientos = items.where(:tipo_item => "movimiento")
		@graves = items.where(:tipo_item => "grave")
	end

	private

	def entrega_turno_params
		params.require(:entrega_turno).permit(:fecha,
      :servicio)
	end

	def find_entrega
  	@entrega = EntregaTurno.find(params[:id])		
	end
end
