class FacturasController < ApplicationController
	before_filter :require_login
	before_filter :suspendido
	before_action :set_factura, only: [:show, :anular, :imprimir]
	before_action :set_cliente, only: :create

#obtiene todas las facturas de venta tipo: ventanilla, consulta externa y hospitalizacion
	def index
		respond_to do |format|
			format.html
			format.json { render json: FacturasDatatable.new(view_context, "venta") }
		end
	end
#obtiene todas las facturas que han sido anuladas
	def index_anulada
		respond_to do |format|
			format.html
			format.json { render json: FacturasDatatable.new(view_context, "anulada") }
		end
	end
# obtiene todas las facturas de compra
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
		unless @factura.anulada
			@factura.anulada = true
			@factura.rollback_factura
			@factura.save
			redirect_to facturas_path, :notice => "Factura Anulada"
		end
	end

	def create
		respond_to do |format|
			if @cliente.save
				@factura = @cliente.facturas.build(factura_params)
				@factura.user_id = current_user.id
				@factura.save
			end
  			format.js
		end
	end

	def update    
		respond_to do |format|
      if @factura.update(factura_params)
        @factura = Factura.all
        format.html { redirect_to @factura, notice: 'Factura modificada exitosamente' }
        format.json { render action: 'show', status: :created, location: @factura }
        # format.js { render "success"}
      else
        format.html { render action: 'edit' }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
        format.js
      end
    end		
	end
	
	private

	def factura_params
		params.require(:factura).permit :observacion,
		:tipo,
		:user_id,
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

	def set_cliente
		cliente_attrs = params[:factura].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)    
  end

end
