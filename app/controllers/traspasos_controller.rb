class TraspasosController < ApplicationController

	def index
	end

	def new
		@traspaso = Traspaso.new
		@traspaso.item_traspasos.build
	end

	def create
		@traspaso.numero = Traspaso.last ? Traspaso.last.numero + 1 : 1
		@traspaso.fecha_emision = Time.now
		@traspaso.user_id = current_user.id
		raise 'error'
		if @traspaso.save
			redirect_to traspaso_path, :notice => "Transferencia realizada"
		else
			flash[:error] = 'Error al realizar traspaso'
		end
	end

	private

	def traspaso_params
		params.require(:traspaso).permit :servicio,
		:fecha_emision,
		:numero,
		:iva,
		:total,
		:user_id,
		:item_traspaso_attributes => [
			:cantidad,
			:valor_unitario,
			:iva,
			:total,
			:producto_id
		]
	end
	
end
