class ConfiguracionesFisiatriaController < ApplicationController
  def index
  	@horario = Horario.new
  	@horarios = Horario.all
  	@tratamiento = Tratamiento.new
  	@tratamiento.item_tratamientos.build
  	@tratamientos = Tratamiento.all
  end
end
