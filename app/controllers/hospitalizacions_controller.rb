class HospitalizacionsController < ApplicationController

	def index
    respond_to do |format|
      format.html
      format.json { render json: HospitalizacionsDatatable.new(view_context) }
    end
  end

	def new
		@hospitalizacion = Hospitalizacion.new
		@hospitalizacion.item_hospitalizacions.build
	end

	def create
		cliente_attrs = params[:hospitalizacion].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
		if @cliente.save
			@hospitalizacion = @cliente.hospitalizacions.build(hospitalizacion_params)
			@hospitalizacion.user_id = current_user.id
			@hospitalizacion.numero = Hospitalizacion.last ? Hospitalizacion.last.numero + 1 : 1
			@hospitalizacion.fecha_emision = Time.now
			if @hospitalizacion.save
				redirect_to hospitalizacions_path, :notice => "Almacenado"
			else
				render 'new'
				flash[:error] = 'Error al Guardar'
			end
		else
			flash[:error] = 'Error en cliente'
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
		:descuento,
		:iva,
		:total,
		:user_id,
		:cliente_id,
		:item_hospitalizacions_attributes => [
			:cantidad,
			:iva,
			:valor_unitario,
			:subtotal,
			:total,
			:ingreso_producto_id
		]
	end
	
end
