class ProformasController < ApplicationController
	before_filter :require_login
  before_action :set_proforma, only: [:show]

	def index
		respond_to do |format|
			format.html
			format.json { render json: ProformasDatatable.new(view_context) }
		end
	end

	def new
		@proforma = Proforma.new
		@proforma.item_proformas.build
		respond_to do |format|
      format.html
      format.js
    end
	end

	def show
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "proforma", :layout => 'report.html', :template => "proformas/proforma_pdf.html.erb"
			end
		end
	end

  def create
  respond_to do |format|
  	cliente_attrs = params[:proforma].delete :cliente
  	@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
  		if @cliente.save
  			@proforma = @cliente.proformas.build(proforma_params)
  			@proforma.numero = Proforma.last ? Proforma.last.numero + 1 : 1
  			@proforma.fecha_emision = Time.now
  			@proforma.save
      end
  		format.js
  	end
  end
  
	def facturar
		@proforma = Proforma.find(params[:id])
		@factura = @proforma.cliente.facturas.build(:tipo => "venta", :tipo_venta=>"ventanilla", :subtotal_0 => @proforma.subtotal_0, :subtotal_12 => @proforma.subtotal_12, :descuento => @proforma.descuento, :iva => @proforma.iva, :total => @proforma.total)
		@factura.user_id = current_user.id
		@factura.numero = Factura.where.not(:tipo => 'compra').last ? Factura.where.not(:tipo => 'compra').last.numero + 1 : 1
		@factura.fecha_de_emision = Time.now
		@factura.fecha_de_vencimiento = Time.now + 30.days
		@factura.item_facturas = Factura.create_items_facturas(@proforma.item_proformas)
		@factura.set_to_item_venta		
		if @factura.save
			redirect_to facturas_path, :notice => "Factura Creada"
		else
			redirect_to proformas_path
			flash[:error] = 'Error al crear la factura'
		end
	end
	private

	def proforma_params
		params.require(:proforma).permit :numero,
		:fecha_emision,
		:subtotal_0,
		:subtotal_12,
		:descuento,
		:iva,
		:total,
		:cliente_id,
		:item_proformas_attributes => [
			:cantidad,
			:valor_unitario,
			:descuento,
			:iva,
			:total,
			:ingreso_producto_id
		]
	end

	def set_proforma
		@proforma = Proforma.find(params[:id])
	end

end
