class ReportesController < ApplicationController
  before_filter :require_login
  include ReportesHelper
  
  def index
  end

  def reporte_total
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura] 
    respond_to do |format|
      format.html{
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
      }
      format.pdf do
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
        render :pdf => "reporte", :layout => 'report.html', :template => "generar_reporte.html.erb", :orientation => 'Landscape'
      end
      format.js
    end
  end

end
