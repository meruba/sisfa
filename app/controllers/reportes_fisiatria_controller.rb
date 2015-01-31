class ReportesFisiatriaController < ApplicationController
  def index
  	@last_registros = ResultadoTratamiento.where(:atendido => true)
  end

  def find_by_personal
  	
  end

  def find_by_paciente
  end
end
