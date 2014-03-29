class HospitalizacionsController < NeedClientController
	before_filter :suspendido
	before_action :set_cliente, only: :create

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
		if @cliente.save
			@hospitalizacion = @cliente.hospitalizacions.build(hospitalizacion_params)
			@hospitalizacion.user_id = current_user.id
			@hospitalizacion.set_hospitalizacion_values
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
