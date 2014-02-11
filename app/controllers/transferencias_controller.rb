class TransferenciasController < ApplicationController

def index
end

def new
	@transferencia = Transferencia.new
	@transferencia.item_transferencias.build
end

def create
	@transferencia = Transferencia.create(transferencia_params)
	if @transferencia.save
		redirect_to transferencia_path, :notice => "Transferencia realizada"
	else
		flash[:error] = 'Error al realizar transferencia'
	end
end

private

def transferencia_params
	params.require(:transferencia).permit :servicio,
																				:fecha_emision,
																				:numero,
																				:iva,
																				:total,
																				:user_id,
																				:item_transferencia_attributes => [
																					:cantidad,
																					:valor_unitario,
																					:iva,
																					:total,
																					:producto_id
																				]
end

end
