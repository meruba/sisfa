class HospitalizacionsController < ApplicationController
	before_filter :require_login
	before_filter :suspendido

	def index
    respond_to do |format|
      format.html
      format.json { render json: HospitalizacionsDatatable.new(view_context) }
    end
  end

	def new
		@hospitalizacion = Hospitalizacion.new
		@hospitalizacion.item_hospitalizacions.build
		@hospitalizacion.build_cliente
	end

	def create
		@hospitalizacion = Hospitalizacion.new(hospitalizacion_params.merge(user_id: current_user.id))
		if @hospitalizacion.save
			redirect_to hospitalizacions_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
	end

	def edit
		@hospitalizacion = Hospitalizacion.find(params[:id])
	end

	def show
		@hospitalizacion = Hospitalizacion.find(params[:id])
		respond_to do |format|
			format.js{ render "show" }
			format.pdf do
				render :pdf => "hospitalizacion", :layout => 'report.html', :template => "hospitalizacions/hospitalizacion_pdf.html.erb"
			end
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
		:cliente_attributes => [
			:id,
			:nombre,
			:direccion,
			:telefono,
			:numero_de_identificacion
		],
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
