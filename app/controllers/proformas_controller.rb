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
	end
	def show
    respond_to do |format|
      format.js
    end
  end
	def create
		cliente_attrs = params[:proforma].delete :cliente
		@cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)
		if @cliente.save
			@proforma = @cliente.proformas.build(proforma_params)
			@proforma.numero = Proforma.last ? Proforma.last.numero + 1 : 1
			@proforma.fecha_emision = Time.now
			if @proforma.save
				redirect_to proformas_path, :notice => "Proforma Guardada"
			else
				flash[:error] = 'Error en la Proforma'
			end
		else
			flash[:error] = 'Errores en Cliente'
			@proforma = Proforma.new(:numero => Proforma.last ? Proforma.last.numero + 1 : 1 )
			@proforma.item_proformas.build
			redirect_to proformas_path
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
			:producto_id
		]
	end

	def set_proforma
		@proforma = Proforma.find(params[:id])
	end
end
