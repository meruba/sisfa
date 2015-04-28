class ItemTratamientosController < ApplicationController

  before_action :find_item, only: [:edit, :update, :suspender]

  def new
    @item = ItemTratamiento.new #CREA UN OBJETO TIPO TRATAMIENTO
  end

  def create
    @item = ItemTratamiento.new(item_tratamiento_params)
    @item.save
    respond_to do |format|
      format.js
    end
  end
  def autocomplete
		respond_to do |format|
			format.json { render :json => ItemTratamiento.autocomplete(params[:term]) }
		end
	end

  def edit
  end

  def update
    respond_to do |format|
      @item_tratamiento.update(item_tratamiento_params)
      format.json { respond_with_bip(@item_tratamiento) }
    end
  end

  def suspender
   if @item_tratamiento.suspendido
      @item_tratamiento.suspendido = false
    else
      @item_tratamiento.suspendido = true
    end
    @item_tratamiento.save
    respond_to do |format|
      format.js
    end
  end

  private

  def item_tratamiento_params
    params.require(:item_tratamiento).permit(:codigo, :nombre, :tratamiento_id)
  end

  def find_item
     @item_tratamiento = ItemTratamiento.find(params[:id])
  end


end
