module DashboardHospitalHelper
	def estadisticas(date)
		@emergencias = EmergenciaRegistro.where(:created_at => date).count()
		@turnos = Turno.where(:fecha => date, :atendido => true).count()
		@hospitalizados = HospitalizacionRegistro.where(:created_at => date).count()
		@preventivas = ConsultaExternaPreventiva.where(:created_at => date).count()
		@morbilidads = ConsultaExternaMorbilidad.where(:created_at => date).count()
	end

# make space calendar
	def number_space(date)
		number = 0
		day = date.beginning_of_month
		case 
		when day.sunday?
			number = 6
		when day.saturday?
			number = 5
		when day.friday?
			number = 4
		when day.thursday?
			number = 3
		when day.wednesday?
			number = 2
		when day.tuesday
			number = 1
		when day.monday?
			number = 0
		end
		number
	end
	
#numero de dias del mes
	def numero_dias(date)
		numero_mes = date.strftime("%m").to_i
    (Date.new(Time.now.year,12,31).to_date<<(12-numero_mes)).day
  end
end
