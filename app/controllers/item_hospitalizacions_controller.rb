class ItemHospitalizacionsController < ApplicationController
	before_filter :require_login
	before_filter :is_admin_or_enfermera_enfermeria, :only => [:create]
	before_filter :is_admin_or_vendedor_farmacia, :only => [:despachar]
	before_action :find_user, :only => [:create]
  before_action :find_item, :only => [:despachar]
  
  def create
		@item = ItemHospitalizacion.new(item_hospitalizacion_params.merge(pedido_por: current_user.cliente.nombre))
		@item.save
		respond_to do |format|
			format.html
			format.js
		end
	end

	def despachar
		unless @item.despachado
			@item.despachado = true
			@item.despachado_por = current_user.cliente.nombre
			@item.save
		end	
		respond_to do |format|
			format.js
		end
	end

	private

	def item_hospitalizacion_params
		params.require(:item_hospitalizacion).permit :hospitalizacion_id,
		:ingreso_producto_id,
		:cantidad,
		:valor_unitario,
		:iva,
		:total,
		:descuento,
		:descripcion,
		:pedido_por,
		:despachado,
		:despachado_por
	end

	def find_item
		@item = ItemHospitalizacion.find(params[:id])
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
