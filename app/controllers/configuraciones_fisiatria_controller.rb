class ConfiguracionesFisiatriaController < ApplicationController
  def index
  	@horario = Horario.new
  	@horarios = Horario.all
  	@tratamientos = Tratamiento.all
  end
end
