class CamasController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
  before_action :find_cama, only: [:destroy]
  
	def create
		@cama = Cama.new(cama_params)
		# @cama.cuarto_id =  @cuarto.id
		@cama.save
    respond_to do |format|
      format.js
    end
	end
	
	def destroy
		respond_to do |format|
			@cama.destroy
			format.js
		end
	end

	private
	def cama_params
		params.require(:cama).permit :numero, :cuarto_id		
	end

	def find_cama
  	@cama = Cama.find(params[:id])		
	end
end
