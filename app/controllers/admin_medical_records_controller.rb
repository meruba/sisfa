class AdminMedicalRecordsController < ApplicationController
  def index
    @doctors = Doctor.includes(:cliente).where(:suspendido => false).references(:cliente)
  end

  def hospitalizaciones
    @resultados = HospitalizacionRegistro.includes(:paciente => :cliente)
    .where(:created_at => params[:fecha_inicial].to_time.beginning_of_month..params[:fecha_final].to_time.end_of_month, :doctor_id => params[:doctor])
    .references(:paciente => :cliente)
    respond_to do |format|
      format.js
    end
  end

  def emergencias
    @resultados = EmergenciaRegistro.includes(:paciente => :cliente)
    .where(:created_at => params[:fecha_inicial].to_time.beginning_of_month..params[:fecha_final].to_time.end_of_month, :doctor_id => params[:doctor])
    .references(:paciente => :cliente)
    respond_to do |format|
      format.js
    end
  end

  def consultas
    if params[:tipo] == '1'
    @resultados = ConsultaExternaMorbilidad.includes(:paciente => :cliente)
    .where(:created_at => params[:fecha_inicial].to_time.beginning_of_month..params[:fecha_final].to_time.end_of_month, :doctor_id => params[:doctor])
    .references(:paciente => :cliente)
    else
    @resultados = ConsultaExternaPreventiva.includes(:paciente => :cliente)
    .where(:created_at => params[:fecha_inicial].to_time.beginning_of_month..params[:fecha_final].to_time.end_of_month, :doctor_id => params[:doctor])
    .references(:paciente => :cliente)
    end
    respond_to do |format|
      format.js
    end
  end

end
