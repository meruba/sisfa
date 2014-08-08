class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_vendedor_farmacia
  
  def generar_reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura] 
    respond_to do |format|
      format.html{
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
      }
      format.pdf do
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte.html.erb", :orientation => 'Landscape'
      end
      format.js
    end
  end

  def liquidaciones
    @fecha = params[:fecha]
    liquidacion(@fecha)
    unless @fecha.to_time > Time.now or @liquidacion.nil?
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "liquidaciones", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "dashboard/liquidaciones.html.erb"
        end
      end
    else
      render :template => "results/not_result"
    end
  end
end
