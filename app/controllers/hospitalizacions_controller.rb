class HospitalizacionsController < ApplicationController
	
	def new
		@hospitalizacion = Hospitalizacion.new
		@hospitalizacion.item_hospitalizacions.build
	end

	def create
		@hospitalizacion = Hospitalizacion.new(hospitalizacion_params)
		@hospitalizacion.numero = Hospitalizacion.last ? Hospitalizacion.last.numero + 1 : 1
		@hospitalizacion.fecha_emision = Time.now
		@hospitalizacion.user_id = current_user.id
		if @hospitalizacion.save
			redirect_to hospitalizacions_path, :notice => "Almacenado"
		else
			flash[:error] = 'Error al Guardar'
		end
	end

	def show
		@hospitalizacion = Hospitalizacion.find(params[:id])
		respond_to do |format|
      format.js{ render "show" }
    end
	end

	private

	def hospitalizacion_params
		params.require(:hospitalizacion).permit :fecha_emision,
		:numero,
		:subtotal,
		:iva,
		:total,
		:user_id,
		:item_hospitalizacions_attributes => [
			:cantidad,
			:valor_unitario,
			:subtotal,
			:total,
			:ingreso_producto_id
		]
	end
	
end
