class FacturasController < NeedClientController
	before_filter :require_login
	before_filter :suspendido
	before_action :set_factura, only: [:show, :anular, :imprimir, :anulado]
	before_action :set_cliente, only: :create

	def index
		respond_to do |format|
			format.html
			format.json { render json: FacturasDatatable.new(view_context, "venta") }
		end
	end

	def index_anulada
		respond_to do |format|
			format.html
			format.json { render json: FacturasDatatable.new(view_context, "anulada") }
		end
	end

	def index_compra
		respond_to do |format|
			format.html
			format.json { render json: FacturasCompraDatatable.new(view_context) }
		end
	end

	def new
		@factura = Factura.new(:tipo => "venta")
		@factura.item_facturas.build		
	end

	def show
		respond_to do |format|
			format.html
			format.js
			format.pdf do
				render :pdf => "factura", :layout => 'report.html', :template => "facturas/venta/factura_pdf.html.erb", :page_size => "A6"
      end
		end
	end
	
	def anular
		respond_to do |format|
			format.js
		end
	end

	def anulado
		unless @factura.anulada
			@factura.anular_factura(params[:razon])
			redirect_to facturas_path, :notice => "Factura Anulada"
		end
	end

	def create
		respond_to do |format|
			if @cliente.save
				@factura = @cliente.facturas.build(factura_params.merge(user_id: current_user.id))
				@factura.save
			end
  			format.js
		end
	end
	
	private

	def factura_params
		params.require(:factura).permit :observacion,
		:tipo,
		:cliente_id,
		:item_facturas_attributes => [
			:cantidad,
			:valor_unitario,
			:descuento,
			:iva,
			:total,
			:tipo,
			:ingreso_producto_id
		]
	end

	def set_factura
		@factura = Factura.find(params[:id])
	end

end
