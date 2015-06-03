class ConfiguracionesFisiatriaController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_fisiatra_fisiatria

  def index
  	@tratamiento = Tratamiento.new
  	@tratamiento.item_tratamientos.build
  	@tratamientos = Tratamiento.all
    @item = ItemTratamiento.new

  end

  def horarios
  	@horario = Horario.new
  	@horarios = Horario.all
    @config = FisiatriaConfiguracion.last
  end

  def certificados
    @config = FisiatriaConfiguracion.last
  end

  def tratamientos
  	index
  end
end
