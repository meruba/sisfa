class ItemNotaEnfermerasController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
  
	def create
		@item = ItemNotaEnfermera.new(item_nota_enfermera_params.merge(fecha: Time.now, user_id: current_user.id))
		@item.save
		respond_to do |format|
			format.js
		end
	end

	private

	def item_nota_enfermera_params
		params.require(:item_nota_enfermera).permit :nota_enfermera_id,
			:fecha,
			:hora,
			:nota
	end
end
