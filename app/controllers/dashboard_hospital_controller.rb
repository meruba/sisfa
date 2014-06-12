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
		# calendario
		@numero_dias = numero_dias(Time.now)
		@espacios = number_space(Time.now)
		# registros
		@emergencias_mes = EmergenciaRegistro.includes(paciente: [:cliente]).where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month).references(paciente: [:cliente])
    @hospitalizados_mes = HospitalizacionRegistro.includes(paciente: [:cliente]).where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month).references(paciente: [:cliente])
	end
end
