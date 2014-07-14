class EnfermedadsController < ApplicationController
  def autocomplete
    respond_to do |format|
      format.json { render :json => Enfermedad.autocomplete(params[:term]) }
    end
  end
end
