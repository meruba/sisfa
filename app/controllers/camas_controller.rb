class CamasController < ApplicationController
  # before_action :find_cuarto, only: [:create]
	def create
		@cama = Cama.new(cama_params)
		# @cama.cuarto_id =  @cuarto.id
		@cama.save
    respond_to do |format|
      format.js
    end
	end

	private
	def cama_params
		params.require(:cama).permit :numero, :cuarto_id		
	end

	def find_cuarto
  	@cuarto = Cuarto.find(params[:id])		
	end
end
