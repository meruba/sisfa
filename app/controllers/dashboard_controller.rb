class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_vendedor_farmacia
  
  include DashboardHelper
  
  def index
    ventas(Time.now.beginning_of_day..Time.zone.now)
  end

  def estadisticas_dia
    ventas(Time.now.beginning_of_day..Time.zone.now)
  end

  def estadisticas_mes
    ventas(Time.now.beginning_of_month..Time.now.end_of_month)
  end

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

  def reportes_cierre_caja_diario
    @fecha = params[:fecha].to_time
    caja_dia(@fecha.beginning_of_day..@fecha.end_of_day)
    if @ventanilla_cantidad == 0
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
    end
  end

  def reportes_cierre_caja_mensual
    @fecha = params[:fecha]
    @liquidacion = Liquidacion.where(:fecha => @fecha).first
    if @liquidacion.nil?
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
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

  def cierre_de_caja_dia
    caja_dia
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        cerrar_caja_dia
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
      end
    end
  end

  def cierre_de_caja_mes
    @fecha = Time.now.beginning_of_month.to_date
    caja_mes(@fecha)
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
      end
    end
  end
end
