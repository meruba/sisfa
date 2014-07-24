class DashboardEnfermeriaController < ApplicationController
	def index
		@sin_camas = HospitalizacionRegistro.includes([paciente: [:cliente]],[:asignacion_cama]).where( :alta => false, :asignacion_camas => { :hospitalizacion_registro_id => nil }).references([paciente: [:cliente]],[:asignacion_cama])
		@camas = HospitalizacionRegistro.includes([paciente: [:cliente]],[:asignacion_cama]).where( :alta => false).where.not(:asignacion_camas => { :hospitalizacion_registro_id => nil }).references([paciente: [:cliente]],[:asignacion_cama])
	end
end
