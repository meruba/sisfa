class ReportesController < ApplicationController
  before_filter :require_login
  include ReportesHelper
  
  def index
  end

  def reporte_total
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo] 
    respond_to do |format|
      format.html{
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
      }
      format.pdf do
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, @tipo_factura)
        render :pdf => "reporte", :layout => 'report.html', :template => "reportes/reporte_total.html.erb", :orientation => 'Landscape'
      end
      format.js
    end
  end

  def liquidaciones
    @fecha = params[:fecha]
    @liquidacion = Liquidacion.where(:fecha => @fecha).first
    unless @fecha.to_time > Time.now or @liquidacion.nil?
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "liquidaciones", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "reportes/liquidaciones.html.erb"
        end
      end
    else
      render :template => "results/not_result"
    end
  end

  def cierre_caja_mensual
    @fecha = params[:fecha]
    @liquidacion = Liquidacion.where(:fecha => @fecha).first
    unless @fecha.to_time > Time.now or @liquidacion.nil?
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "caja_mensual", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "reportes/cierre_caja_mensual.html.erb"
        end
      end
    else
      render :template => "results/not_result"
    end
  end

  def cierre_caja_diario
    @fecha = params[:fecha]
    @cierre_caja = CierreCaja.where(:created_at => @fecha.to_time.beginning_of_day..@fecha.to_time.end_of_day, :is_cerrado => true)
    # raise
    unless @fecha.to_time > Time.now or @cierre_caja.empty?
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "caja_mensual", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "reportes/cierre_caja_diario.html.erb"
        end
      end
    else
      render :template => "results/not_result"
    end
  end
end
