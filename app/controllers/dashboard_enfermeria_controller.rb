class DashboardEnfermeriaController < ApplicationController
	def index
		@registros = HospitalizacionRegistro.includes(:paciente => :cliente).where(:alta => false).references(:paciente => :cliente)
	end
end
