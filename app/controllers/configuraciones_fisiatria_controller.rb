class ConfiguracionesFisiatriaController < ApplicationController
  def index
  	@horario = Horario.new
  	@horarios = Horario.all
  end
end
