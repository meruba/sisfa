class ReportesFisiatriaController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_fisiatra_fisiatria

	def index
	end

	def personal
		@terapista = Personal.find(params[:personal])
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		@resultados = ResultadoTratamiento.where(:personal_id => params[:personal], :fecha => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de terapista", :layout => 'report.html', :template => "reportes_fisiatria/reporte_personal.pdf.erb", :orientation => 'Landscape'
			end
		end
	end

	def search_paciente
		@paciente = Paciente.find(params[:paciente_id])
		@resultados =  AsignarHorario.includes(:paciente).where(:paciente_id => params[:paciente_id], :created_at => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day).references(:paciente)
		respond_to do |format|
			format.js
		end
	end

	def paciente
		@paciente = Paciente.find(params[:paciente_id])
		horario =  AsignarHorario.find(params[:registro].to_i)
		@resultados =  horario.resultado_tratamientos
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de paciente", :layout => 'report.html', :template => "reportes_fisiatria/reporte_paciente.pdf.erb", :orientation => 'Landscape'
			end
		end
	end

	def paciente_certificado
		@paciente = Paciente.find(params[:paciente_id])
		@terapia =  AsignarHorario.find(params[:registro].to_i)
		@resultados =  @terapia.resultado_tratamientos
    @certificado = FisiatriaConfiguracion.last
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "certificado de paciente", :layout => 'report.html', :template => "reportes_fisiatria/certificado_paciente.pdf.erb"
			end
		end
	end

	def factura
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		if params[:tipo] == "1"
			@resultados =  AsignarHorario.where(:created_at => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
		else
			@resultados =  AsignarHorario.where(:numero_factura => params[:numero_inicial]..params[:numero_final])
		end
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de factura", :layout => 'report.html', :template => "reportes_fisiatria/reporte_factura.pdf.erb"
			end
		end
	end
end
