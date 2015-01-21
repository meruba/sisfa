class ItemTratamientosController < ApplicationController
	def autocomplete
		respond_to do |format|
			format.json { render :json => ItemTratamiento.autocomplete(params[:term]) }
		end
	end
end
