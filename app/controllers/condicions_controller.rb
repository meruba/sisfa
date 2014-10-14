class CondicionsController < ApplicationController
	before_filter :require_login
	before_filter :shared_permission

	def show
		@condicion = Condicion.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

end
