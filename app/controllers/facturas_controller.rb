class FacturasController < ApplicationController
	before_filter :require_login
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

	def venta
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
		if @cliente.save
			@factura = @cliente.facturas.build(factura_params)
			@factura.user_id = current_user.id
			@factura.fecha_de_emision = Time.now
			@factura.fecha_de_vencimiento = Time.now + 30.days
			@factura.numero = Factura.last ? Factura.last.numero + 1 : 1
			@factura.set_to_item_venta
			if @factura.save
				redirect_to @factura, :notice => "Factura Guardada"
			else
				render 'venta'
				flash[:error] = 'Error'
			end
		else
			flash[:error] = 'Error en cliente'
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
