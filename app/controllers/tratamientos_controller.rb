class TratamientosController < ApplicationController

  before_action :find_tratamiento, only: [:edit, :update]
	def index
	end
	def new
		@tratamiento = Tratamiento.new #CREA UN OBJETO TIPO TRATAMIENTO
		@tratamiento.item_tratamientos.build #permite crear itemtratamientos
	end
	def create
		@tratamiento = Tratamiento.new(tratamiento_params)
		@tratamiento.save
		respond_to do |format|
			format.js{
        @item = ItemTratamiento.new
      }
		end
	end

	def edit

	end

	def update
    respond_to do |format|
      @tratamiento.update(tratamiento_params)
      format.json { respond_with_bip(@tratamiento) }
    end
	end

	private

	def tratamiento_params
		params.require(:tratamiento).permit(:nombre,
		 :numeracion,
		 :item_tratamientos_attributes=>[ :codigo, :nombre, :tratamiento_id, :_destroy]
		 )
	end

	def find_tratamiento
     @tratamiento = Tratamiento.find(params[:id])
   end
end
