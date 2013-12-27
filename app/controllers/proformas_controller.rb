class ProformasController < ApplicationController
	before_filter :require_login
	
	def new
		@proforma = Proforma.new
		@proforma.item_proforma.build
	end

	
	def create
		cliente_attrs = params[:proforma].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
		if @cliente.save
			@proforma = @cliente.proformas.build(proforma_params)
			@proforma.numero = Proforma.last ? Proforma.last.numero + 1 : 1
			@proforma.fecha_de_emision = Time.now
			@proforma.fecha_de_vencimiento = Time.now + 30.days
			Proforma.disminuir_stock(@proforma.item_proformas)
			if @proforma.save
				redirect_to proformas_path, :notice => "Proforma Guardada"
			else
				render "new"
			end
		else
			flash[:error] = 'Errores en Cliente'
			@proforma = Prtoforma.new(:numero => Proforma.last ? Proforma.last.numero + 1 : 1 )
			@proforma.item_proformas.build
			render "new"
		end 
	end

private

	def proforma_params
		params.require(:proforma).permit :numero,
																		:observacion,
																		:fecha_de_emision,
																		:fecha_de_vencimiento,
																		:subtotal_0,
																		:subtotal_12,
																		:descuento,
																		:iva,
																		:total,
																		:tipo,
																		:cliente_id,
																		:item_proformas_attributes => [
																			:cantidad,
																			:valor_unitario,
																			:descuento,
																			:iva,
																			:total,
																			:producto_id
																		]
	end
end
