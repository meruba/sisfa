class DashboardHospitalController < ApplicationController
  include DashboardHospitalHelper

	def index
    estadisticas(Time.now.beginning_of_day..Time.zone.now)
	end

	def estadisticas_hoy
    estadisticas(Time.now.beginning_of_day..Time.zone.now)
	end

	def estadisticas_mes
    estadisticas(Time.now.beginning_of_month..Time.now.end_of_month)
	end

	def ingresados
		@emergencias_mes = EmergenciaRegistro.includes(:paciente).where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month).references(:paciente)
    @hospitalizados_mes = HospitalizacionRegistro.includes(:paciente).where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month).references(:paciente)
	end
end
