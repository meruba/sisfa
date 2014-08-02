class DashboardEnfermeriaController < ApplicationController
	before_filter :require_login
  before_filter :is_admin_or_enfermera_enfermeria
	def index
		@sin_camas = HospitalizacionRegistro.includes([paciente: [:cliente]],[:asignacion_cama]).where( :alta => false, :asignacion_camas => { :hospitalizacion_registro_id => nil }).references([paciente: [:cliente]],[:asignacion_cama])
		@camas = HospitalizacionRegistro.includes([paciente: [:cliente]],[:asignacion_cama]).where(:alta_enfermeria => false).where.not(:asignacion_camas => { :hospitalizacion_registro_id => nil }).references([paciente: [:cliente]],[:asignacion_cama])
	end
end
