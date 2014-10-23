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
		@pedidos =  Hospitalizacion.includes(hospitalizacion_registro: [paciente: [:cliente]]).where("hospitalizacion_registros.alta_enfermeria = false").references(hospitalizacion_registro: [paciente: [:cliente]])
  end

	def show_pedido
		@item = ItemHospitalizacion.new
		@hospitalizacion = Hospitalizacion.includes(hospitalizacion_registro: [paciente: [:cliente]]).where(id: params[:hospitalizacion_id]).references(hospitalizacion_registros: [paciente: [:cliente]]).first
		@items = @hospitalizacion.item_hospitalizacions.includes(ingreso_producto: [:producto]).order('item_hospitalizacions.created_at DESC').references(ingreso_producto: [:producto])
		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "reporte de consumo", :layout => 'report.html', :template => "hospitalizacions/reporte_consumo_pdf.html.erb", :orientation => 'Landscape'
      end
		end
	end

	def show
		@items = @hospitalizacion.grouped_by_categoria()
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
		@hospitalizacion = Hospitalizacion.includes(item_hospitalizacions: [ingreso_producto: [:producto]]).where(id: params[:id]).references(item_hospitalizacions: [ingreso_producto: [:producto]]).first
	end

	def find_user #views
		if current_user.rol == Rol.administrador_farmacia or current_user.rol == Rol.vendedor or current_user.rol == Rol.administrador
			@permiso_farmacia = true
		end
		if current_user.rol == Rol.administrador_enfermeria or current_user.rol == Rol.enfermera or current_user.rol == Rol.administrador
			@permiso_enfermeria = true
		end
	end
end
