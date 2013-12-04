class FacturasController < ApplicationController
	
	def new
		@factura = Factura.new
		@factura.build_cliente
		# @factura.build_item_factura
	end

	def create
		@factura = Factura.new(factura_params)
		  if @factura.save
        redirect_back_or_to(clientes_path, notice: "Factura Creada")
      else
        flash[:error] = "Error al Facturar"
      end
	end

	private

	def factura_params
	  params.require(:factura).permit :numero,
	  																:observacion,
	  																:fecha_de_emision,
	  																:fecha_de_vencimiento,
	  																:subtotal_0,
	  																:subtotal_12,
	  																:descuento,
	  																:iva,
	  																:total,
	  																:cliente_attributes => [
                                      :nombre,
                                      :direccion,
                                      :telefono,
                                      :numero_de_identificacion,
                                      :email,
                                      :created_at,
                                      :updated_at
                                    ],
                                    :item_factura_attributes => [
                                    	:cantidad,
                                    	:valor_unitario,
                                    	:descuento,
                                    	:iva,
                                    	:total
                                    ]
	end
end
