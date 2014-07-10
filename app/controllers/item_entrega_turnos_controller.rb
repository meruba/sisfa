class ItemEntregaTurnosController < ApplicationController
  before_action :find_entrega, only: [:create]
	def create
		@item = ItemEntregaTurno.new(item_entrega_turno_params.merge(user_id: current_user.id))
		@item.entrega_turno_id =  @entrega.id
		if @item.save
			redirect_to entrega_turno_view_create_item_path(@entrega), :notice => "Almacenado"
		else
			redirect_to entrega_turno_view_create_item_path(@entrega), :notice => "Error"
		end
	end

	private

	def item_entrega_turno_params
		params.require(:item_entrega_turno).permit(:tipo_item,
			:descripcion,
			:hospitalizacion_registro_id)
	end

	def find_entrega
  	@entrega = EntregaTurno.find(params[:entrega_turno_id])	
	end
end
