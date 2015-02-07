class ConfiguracionesFisiatriaController < ApplicationController
  def index
  	@tratamiento = Tratamiento.new
  	@tratamiento.item_tratamientos.build
  	@tratamientos = Tratamiento.all
  end
  def horarios
  	@horario = Horario.new
  	@horarios = Horario.all
  end

  def tratamientos
  	@tratamiento = Tratamiento.new
  	@tratamiento.item_tratamientos.build
  	@tratamientos = Tratamiento.all
  end

  def sistema

  end
end
