class ConfiguracionesFisiatriaController < ApplicationController
  def index
  	@tratamiento = Tratamiento.new
  	@tratamiento.item_tratamientos.build
  	@tratamientos = Tratamiento.all
    @item = ItemTratamiento.new

  end
  def horarios
  	@horario = Horario.new
  	@horarios = Horario.all
  end

  def tratamientos
  	index
  end

  def sistema

  end
end
