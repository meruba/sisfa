module DashboardHospitalHelper
	def estadisticas(date)
		@emergencias = EmergenciaRegistro.where(:created_at => date).count()
		@turnos = Turno.where(:fecha => date, :atendido => true).count()
		@hospitalizados = HospitalizacionRegistro.where(:created_at => date).count()
		@preventivas = ConsultaExternaPreventiva.where(:created_at => date).count()
		@morbilidads = ConsultaExternaMorbilidad.where(:created_at => date).count()
	end
end
