class HorariosController < ApplicationController

  before_action :find_horario, only: [:edit, :update, :suspender]

	def new
		@horario = Horario.new
		@horarios = Horario.all
	end

	def create
		@horario = Horario.new(horario_params)
		@horario.save
		respond_to do |format|
			format.js
		end
	end

	def suspender
    if @horario.anulado
      @horario.anulado = false
    else
      @horario.anulado = true
    end
    @horario.save
    respond_to do |format|
      format.js
    end
	end


	private

	def horario_params
		params.require(:horario).permit(:hora, :hora_inicio, :hora_final)
	end

  def find_horario
    @horario = Horario.find(params[:id])
  end
end
