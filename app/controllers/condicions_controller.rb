class CondicionsController < ApplicationController
	before_filter :require_login

	def show
		@condicion = Condicion.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

end
