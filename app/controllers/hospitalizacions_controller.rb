class HospitalizacionsController < ApplicationController
	before_filter :require_login
	before_action :find_user, :only => [:show_pedido]
	before_filter :find_hospitalizacion, :only => [:show]

	def index
    respond_to do |format|
      format.html
      format.json { render json: HospitalizacionsDatatable.new(view_context) }
      format.js
    end
  end

  def pedidos
		@pedidos =  Hospitalizacion.includes(:hospitalizacion_registro).where("hospitalizacion_registros.alta_enfermeria = false").references(:hospitalizacion_registro)
  end

	def show_pedido
		@item = ItemHospitalizacion.new
		@hospitalizacion = Hospitalizacion.find(params[:hospitalizacion_id])
		@items = @hospitalizacion.item_hospitalizacions.order('created_at DESC')
	end

	def show
		respond_to do |format|
			format.js
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
			:id,
			:cantidad,
			:iva,
			:valor_unitario,
			:subtotal,
			:total,
			:ingreso_producto_id
		]
	end

	def find_hospitalizacion
		@hospitalizacion = Hospitalizacion.find(params[:id])
	end

	def find_user
		if current_user.rol == Rol.administrador_farmacia or current_user.rol == Rol.vendedor
			@permiso =  false
		else
			@permiso = true
		end
	end
end
