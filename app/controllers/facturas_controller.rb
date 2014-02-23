class FacturasController < ApplicationController
	before_filter :require_login
	before_action :set_factura, only: [:show, :anular]

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
			format.json { render json: FacturasDatatable.new(view_context, "compra") }
		end
	end

	def venta
		@factura = Factura.new(:tipo => "venta", :tipo_venta=>"ventanilla")
	end

	def show
		respond_to do |format|
			format.js
		end
	end

	def compra
		@factura = Factura.new(:tipo => "compra") 
		@factura.item_facturas.build
		# respond_to do |format|
		# 	format.html
		# 	format.js
		# end
	end

	def ventanilla
		@factura = Factura.new(:tipo => "venta", :tipo_venta=>"ventanilla")
		@factura.item_facturas.build
		respond_to do |format|
			# format.html
			format.js
		end
	end

	def hospitalizacion
		@factura = Factura.new(:tipo => "venta", :tipo_venta=>"hospitalizacion")
		@factura.item_facturas.build
		respond_to do |format|
			# format.html
			format.js
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
		if params[:factura].include?(:cliente)
				create_factura_venta
		else
			create_factura_compra
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

	def create_factura_venta
		cliente_attrs = params[:factura].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
		respond_to do |format|
			if @cliente.save
				@factura = @cliente.facturas.build(factura_params)
				@factura.user_id = current_user.id
				@factura.numero = Factura.where.not(:tipo => 'compra').last ? Factura.where.not(:tipo => 'compra').last.numero + 1 : 1
				@factura.fecha_de_emision = Time.now
				@factura.fecha_de_vencimiento = Time.now + 30.days
				@factura.set_to_item_venta
				@factura.save
			end
			format.js
		end
	end

	def create_factura_compra
		proveedor_attrs = params[:factura].delete :proveedor
		@proveedor = proveedor_attrs[:id].present? ? Proveedor.update(proveedor_attrs[:id],proveedor_attrs) : Proveedor.create(proveedor_attrs)
		if @proveedor.save
			@factura = @proveedor.facturas.build(factura_params)
			@factura.user_id = current_user.id
			@factura.fecha_de_emision = Time.now
			@factura.fecha_de_vencimiento = Time.now + 30.days
			Factura.item_compra(@factura.item_facturas)
				# raise 'error'
			if @factura.save
				Factura.aumentar_stock(@factura.item_facturas)
				# redirect_to "compra", :notice => "Factura Guardada"
				redirect_to facturas_path, :notice => "Factura Guardada"
			else
				# render "compra"
				flash[:error] = "Error al facturar"
				redirect_to facturas_path
			end
		else
			flash[:error] = 'Errores en Proveedor'
			@factura.item_facturas.build
			render "new"
		end 
	end

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
		:tipo_venta,
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
end
