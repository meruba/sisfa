class TraspasosController < ApplicationController

	 def index
    respond_to do |format|
      format.html
      format.json { render json: TraspasosDatatable.new(view_context) }
    end
  end

	def new
		@traspaso = Traspaso.new
		@traspaso.item_traspasos.build
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		respond_to do |format|
			@traspaso = Traspaso.new(traspaso_params)
			@traspaso.numero = Traspaso.last ? Traspaso.last.numero + 1 : 1
			@traspaso.fecha_emision = Time.now
			@traspaso.user_id = current_user.id
			@traspaso.save
  		format.js
		end	
	end

	def show
		@traspaso = Traspaso.find(params[:id])
		respond_to do |format|
      format.js
      format.pdf do
				render :pdf => "proforma", :layout => 'report.html', :template => "traspasos/traspaso_pdf.html.erb"
			end
    end
	end

	private

	def traspaso_params
		params.require(:traspaso).permit :servicio,
		:fecha_emision,
		:numero,
		:subtotal,
		:iva,
		:total,
		:user_id,
		:item_traspasos_attributes => [
			:cantidad,
			:valor_unitario,
			:iva,
			:total,
			:ingreso_producto_id
		]
	end
	
end
