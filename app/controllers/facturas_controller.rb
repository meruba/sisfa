class FacturasController < ApplicationController
	before_filter :require_login
  before_action :set_factura, only: [:show]

	def index
		respond_to do |format|
			format.html
			format.json { render json: FacturasDatatable.new(view_context) }
		end
	end

	def venta
		@factura = Factura.new(:tipo=>"ventanilla")
	end

  def show
    respond_to do |format|
      format.js
    end
  end

	def ventanilla
		@factura = Factura.new(:tipo=>"ventanilla")
		@factura.item_facturas.build
		respond_to do |format|
			# format.html
			format.js
		end
	end
	
	def consulta_externa
		@factura = Factura.new(:tipo=>"consulta_externa")
		@factura.item_facturas.build
		respond_to do |format|
			# format.html
			format.js
		end
	end

	def hospitalizacion
		@factura = Factura.new(:tipo=>"hospitalizacion")
		@factura.item_facturas.build
		respond_to do |format|
			# format.html
			format.js
		end
	end

	def anular
	end

	def create
		cliente_attrs = params[:factura].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
		if @cliente.save
			@factura = @cliente.facturas.build(factura_params)
			@factura.numero = Factura.last ? Factura.last.numero + 1 : 1
			@factura.fecha_de_emision = Time.now
			@factura.fecha_de_vencimiento = Time.now + 30.days
			Factura.disminuir_stock(@factura.item_facturas)
			if @factura.save
				redirect_to facturas_path, :notice => "Factura Guardada"
			else
				render "new"
			end
		else
			flash[:error] = 'Errores en Cliente'
			@factura = Factura.new(:numero => Factura.last ? Factura.last.numero + 1 : 1 )
			@factura.item_facturas.build
			render "new"
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
		:tipo,
		:cliente_id,
		:item_facturas_attributes => [
			:cantidad,
			:valor_unitario,
			:descuento,
			:iva,
			:total,
			:producto_id
		]
	end

	def set_factura
		@factura = Factura.find(params[:id])
	end
end
